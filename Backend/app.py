# ==================== IMPORTS ====================
from datetime import datetime, timedelta
import os
import re
import mysql.connector
from flask import Flask, jsonify, request
from flask_cors import CORS
from mysql.connector import Error, errorcode
from werkzeug.security import check_password_hash, generate_password_hash

# Local module imports
from config import DB_CONFIG, OTP_EXPIRES_MINUTES, ADMINS_DATA
from utils import generate_otp, send_email, save_and_email_otp
from database import (
    get_db_connection, 
    init_database, 
    fetch_properties_from_db,
    create_admins_table,
    insert_or_update_admins,
    hash_admin_passwords,
    test_database_connection
)

# ==================== APP INITIALIZATION ====================
app = Flask(__name__)
# Enable CORS for all origins (development mode)
CORS(app, resources={
    r"/*": {
        "origins": "*",
        "methods": ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        "allow_headers": ["Content-Type", "Authorization"]
    }
})

# In-memory store for pending registrations - keeps DB clean until OTP verified
pending_registrations = {}

# ==================== API ENDPOINTS ====================

@app.route('/api/properties', methods=['GET'])
def get_properties():
    """Get all properties or filter by listing type."""
    property_type = request.args.get('type', None)
    listing_type = request.args.get('listing_type', None)

    properties = fetch_properties_from_db()

    if property_type:
        filtered_properties = [p for p in properties if p.get('type') == property_type]
        return jsonify(filtered_properties)

    if listing_type:
        filtered_properties = [p for p in properties if p.get('type') == listing_type.lower()]
        return jsonify(filtered_properties)

    return jsonify(properties)


@app.route('/api/properties/<int:property_id>', methods=['GET'])
def get_property_by_id(property_id):
    """Get a specific property by ID"""
    properties = fetch_properties_from_db()
    property = next((p for p in properties if p['id'] == property_id), None)
    
    if not property:
        return jsonify({"error": "Property not found"}), 404
    
    # Debug: Log what data is being returned
    print(f"Property {property_id} data:")
    print(f"  BHK: {property.get('bhk')}")
    print(f"  Furnish: {property.get('furnish')}")
    print(f"  Furnishing: {property.get('furnishing')}")
    
    return jsonify(property)


@app.route('/api/agents/top', methods=['GET'])
def get_top_agents():
    """Fetch top 10 agents from OWNERS table based on property count."""
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        cursor = connection.cursor(dictionary=True)
        query = """
            SELECT 
                o.owner_id, 
                o.name, 
                o.phone,
                o.email,
                COUNT(po.property_id) as total_properties
            FROM owners o
            LEFT JOIN property_owner po ON po.owner_id = o.owner_id
            WHERE o.role = 'Agent'
            GROUP BY o.owner_id
            ORDER BY total_properties DESC
            LIMIT 10
        """
        cursor.execute(query)
        agents = cursor.fetchall()

        for agent in agents:
            loc_query = """
                SELECT DISTINCT pl.area
                FROM property_location pl
                JOIN property_owner po ON po.property_id = pl.property_id
                WHERE po.owner_id = %s
                LIMIT 2
            """
            cursor.execute(loc_query, (agent['owner_id'],))
            locations = [row['area'] for row in cursor.fetchall()]
            agent['locations'] = locations

        connection.close()
        return jsonify(agents)

    except Error as e:
        print(f"Error fetching top agents: {e}")
        if connection and connection.is_connected():
            connection.close()
        return jsonify({"error": str(e)}), 500

@app.route('/api/properties', methods=['POST'])
def add_property():
    """Add a new property with location and owner links."""
    data = request.json or {}

    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        cursor = connection.cursor()

        insert_property = """
        INSERT INTO properties (
            title, description, property_category, property_type, listing_type, 
            sale_type, price, area_sqft, bedrooms, bathrooms, balconies, 
            furnishing_status, floor_number, total_floors, property_age, 
            facing, covered_parking, availability_status
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 'Available')
        """

        property_values = (
            data.get('title'),
            data.get('description'),
            data.get('property_category'),
            data.get('property_type'),
            data.get('listing_type'),
            data.get('sale_type', 'New'),
            data.get('price'),
            data.get('area_sqft'),
            data.get('bedrooms'),
            data.get('bathrooms'),
            data.get('balconies'),
            data.get('furnishing_status'),
            data.get('floor_number'),
            data.get('total_floors'),
            data.get('property_age'),
            data.get('facing'),
            data.get('covered_parking', 0)
        )

        cursor.execute(insert_property, property_values)
        property_id = cursor.lastrowid

        insert_location = """
        INSERT INTO property_location (property_id, city, area, address, pincode)
        VALUES (%s, %s, %s, %s, %s)
        """
        
        location_values = (
            property_id,
            "Ahmedabad",
            data.get('locality', 'Ahmedabad'),
            data.get('address'),
            data.get('pincode', '')
        )
        cursor.execute(insert_location, location_values)

        insert_owner = "INSERT INTO property_owner (property_id, owner_id) VALUES (%s, %s)"
        cursor.execute(insert_owner, (property_id, 1))

        connection.commit()
        connection.close()

        return jsonify({"message": "Property posted successfully", "property_id": property_id}), 201

    except Error as e:
        print(f"Error inserting property: {e}")
        if connection:
            connection.rollback()
            connection.close()
        return jsonify({"error": str(e)}), 500


@app.route('/api/contact', methods=['POST'])
def submit_contact():
    """Handle contact form submissions, save to database and send email to admins."""
    data = request.json or {}
    
    name = (data.get('name') or '').strip()
    email = (data.get('email') or '').strip()
    phone = (data.get('phone') or '').strip()
    subject = (data.get('subject') or '').strip()
    message = (data.get('message') or '').strip()
    
    # Validate required fields
    if not all([name, email, subject, message]):
        return jsonify({"error": "All fields except phone are required."}), 400
    
    # Validate email format
    email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    if not re.match(email_pattern, email):
        return jsonify({"error": "Invalid email format."}), 400
    
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        # Save contact message to database
        cursor = connection.cursor()
        cursor.execute(
            """INSERT INTO contact_messages (name, email, phone, subject, message, status) 
               VALUES (%s, %s, %s, %s, %s, 'new')""",
            (name, email, phone or None, subject, message)
        )
        connection.commit()
        message_id = cursor.lastrowid
        connection.close()
        
        # Prepare email body for admin
        admin_email_body = (
            f"New Contact Form Submission (ID: {message_id})\n"
            f"{'='*50}\n\n"
            f"Name: {name}\n"
            f"Email: {email}\n"
            f"Phone: {phone or 'Not provided'}\n"
            f"Subject: {subject}\n\n"
            f"Message:\n{message}\n\n"
            f"{'='*50}\n"
            f"Submitted on: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')} UTC\n"
        )
        
        # Send email to all admins
        for admin in ADMINS_DATA:
            try:
                send_email(admin['email'], f"FindMyRoof Contact: {subject}", admin_email_body)
            except Exception as e:
                print(f"Failed to send email to {admin['email']}: {e}")
        
        # Send confirmation email to user
        user_email_body = (
            f"Hi {name},\n\n"
            f"Thank you for contacting FindMyRoof!\n\n"
            f"We have received your message regarding '{subject}' and will get back to you as soon as possible.\n\n"
            f"Your Message:\n{message}\n\n"
            f"If you have any urgent queries, please feel free to reach out to us directly.\n\n"
            f"Best regards,\n"
            f"FindMyRoof Team\n"
        )
        
        try:
            send_email(email, "Thank you for contacting FindMyRoof", user_email_body)
        except Exception as e:
            print(f"Failed to send confirmation email to user: {e}")
        
        return jsonify({
            "message": "Thank you for contacting us! We'll get back to you soon.",
            "message_id": message_id
        }), 200
        
    except Exception as e:
        print(f"Error in contact form submission: {e}")
        if connection:
            connection.close()
        return jsonify({"error": "Failed to send your message. Please try again later."}), 500


@app.route('/api/contact-messages', methods=['GET'])
def get_contact_messages():
    """Get all contact messages (for admin) with optional filtering."""
    status_filter = request.args.get('status', None)  # Filter by status: 'new', 'read', 'replied', 'archived'
    
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        cursor = connection.cursor(dictionary=True)
        
        if status_filter:
            cursor.execute(
                """SELECT id, name, email, phone, subject, message, status, 
                          created_at, updated_at 
                   FROM contact_messages 
                   WHERE status = %s 
                   ORDER BY created_at DESC""",
                (status_filter,)
            )
        else:
            cursor.execute(
                """SELECT id, name, email, phone, subject, message, status, 
                          created_at, updated_at 
                   FROM contact_messages 
                   ORDER BY created_at DESC"""
            )
        
        messages = cursor.fetchall()
        connection.close()
        
        # Format dates for JSON serialization
        for msg in messages:
            if msg.get('created_at'):
                msg['created_at'] = msg['created_at'].strftime('%Y-%m-%d %H:%M:%S')
            if msg.get('updated_at'):
                msg['updated_at'] = msg['updated_at'].strftime('%Y-%m-%d %H:%M:%S')
        
        return jsonify(messages), 200
        
    except Exception as e:
        print(f"Error retrieving contact messages: {e}")
        if connection:
            connection.close()
        return jsonify({"error": "Failed to retrieve messages"}), 500


@app.route('/api/contact-messages/<int:message_id>', methods=['GET'])
def get_contact_message(message_id):
    """Get a specific contact message by ID."""
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        cursor = connection.cursor(dictionary=True)
        cursor.execute(
            """SELECT id, name, email, phone, subject, message, status, 
                      created_at, updated_at 
               FROM contact_messages 
               WHERE id = %s""",
            (message_id,)
        )
        
        message = cursor.fetchone()
        connection.close()
        
        if not message:
            return jsonify({"error": "Message not found"}), 404
        
        # Format dates
        if message.get('created_at'):
            message['created_at'] = message['created_at'].strftime('%Y-%m-%d %H:%M:%S')
        if message.get('updated_at'):
            message['updated_at'] = message['updated_at'].strftime('%Y-%m-%d %H:%M:%S')
        
        return jsonify(message), 200
        
    except Exception as e:
        print(f"Error retrieving contact message: {e}")
        if connection:
            connection.close()
        return jsonify({"error": "Failed to retrieve message"}), 500


@app.route('/api/contact-messages/<int:message_id>/status', methods=['PUT'])
def update_contact_message_status(message_id):
    """Update the status of a contact message."""
    data = request.json or {}
    new_status = data.get('status', '').strip()
    
    # Validate status
    valid_statuses = ['new', 'read', 'replied', 'archived']
    if new_status not in valid_statuses:
        return jsonify({"error": f"Invalid status. Must be one of: {', '.join(valid_statuses)}"}), 400
    
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        cursor = connection.cursor()
        cursor.execute(
            "UPDATE contact_messages SET status = %s WHERE id = %s",
            (new_status, message_id)
        )
        
        if cursor.rowcount == 0:
            connection.close()
            return jsonify({"error": "Message not found"}), 404
        
        connection.commit()
        connection.close()
        
        return jsonify({"message": "Status updated successfully", "status": new_status}), 200
        
    except Exception as e:
        print(f"Error updating contact message status: {e}")
        if connection:
            connection.close()
        return jsonify({"error": "Failed to update status"}), 500


@app.route('/api/contact-messages/<int:message_id>', methods=['DELETE'])
def delete_contact_message(message_id):
    """Delete a contact message (admin only)."""
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        cursor = connection.cursor()
        cursor.execute("DELETE FROM contact_messages WHERE id = %s", (message_id,))
        
        if cursor.rowcount == 0:
            connection.close()
            return jsonify({"error": "Message not found"}), 404
        
        connection.commit()
        connection.close()
        
        return jsonify({"message": "Message deleted successfully"}), 200
        
    except Exception as e:
        print(f"Error deleting contact message: {e}")
        if connection:
            connection.close()
        return jsonify({"error": "Failed to delete message"}), 500


@app.route('/api/users/register', methods=['POST'])
def register_user():
    """Register a new user while handling duplicate email/phone errors."""
    data = request.json or {}

    email = (data.get('email') or '').strip()
    password = str(data.get('password') or '')
    confirm_password = str(data.get('confirm_password') or password)
    full_name = (data.get('full_name') or '').strip()
    phone = (data.get('phone') or '').strip()
    role = (data.get('role') or 'user').strip().lower()

    errors = []
    if not email or not re.fullmatch(r'[A-Za-z0-9._%+-]+@gmail\.com', email):
        errors.append('Valid Gmail address is required (e.g., user@gmail.com)')
    if not full_name:
        errors.append('Full name is required')
    if not 8 <= len(password) <= 12:
        errors.append('Password must be 8 to 12 characters long')
    if ' ' in password:
        errors.append('Password cannot contain spaces')
    if not re.search(r'[A-Za-z]', password) or not re.search(r'\d', password):
        errors.append('Password must include letters and digits')
    if phone and (not re.fullmatch(r'[9876]\d{9}', phone)):
        errors.append('Phone must be 10 digits and start with 9, 8, 7, or 6')
    if role not in ['user', 'admin']:
        errors.append('Role must be user or admin')
    if password != confirm_password:
        errors.append('Password and confirm password must match')

    if errors:
        return jsonify({"error": errors}), 400

    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT 1 FROM users WHERE email = %s OR phone = %s", (email, phone or None))
        if cursor.fetchone():
            connection.close()
            return jsonify({"error": {"email": "Email or phone already registered"}}), 409
        connection.close()

        otp = generate_otp()
        otp_expires_at = datetime.utcnow() + timedelta(minutes=int(os.getenv('OTP_EXPIRES_MINUTES', '2')))
        pending_registrations[email] = {
            "full_name": full_name,
            "email": email,
            "phone": phone or None,
            "password_hash": generate_password_hash(password),
            "role": role,
            "otp_code": otp,
            "otp_expires_at": otp_expires_at,
            "otp_last_sent_at": datetime.utcnow()
        }

        try:
            email_body = (
                f"Hi {full_name or 'User'},\n\n"
                f"Your One-Time Password (OTP) for registration is:\n\n"
                f"👉  {otp}  👈\n\n"
                f"This OTP is valid for {int(os.getenv('OTP_EXPIRES_MINUTES', '2'))} minutes.\n"
                "Please do not share this code with anyone for security reasons.\n\n"
                "If you did not request this OTP, you can safely ignore this email.\n\n"
                "Regards,\n"
                "FindMyRoof Team\n"
            )
            send_email(email, 'Registration OTP', email_body)
        except Exception as e:
            pending_registrations.pop(email, None)
            return jsonify({"error": f"Failed to send OTP: {e}"}), 502

        return jsonify({
            "message": "Registration started. OTP sent to email for verification.",
            "email": email,
            "full_name": full_name,
            "role": role,
            "requires_otp": True
        }), 201
    except Error as e:
        connection.rollback()
        connection.close()
        if getattr(e, 'errno', None) == errorcode.ER_DUP_ENTRY:
            msg = str(e)
            if 'email_unique' in msg:
                return jsonify({"error": {"email": "Email already registered"}}), 409
            if 'phone_unique' in msg:
                return jsonify({"error": {"phone": "Phone already registered"}}), 409
            return jsonify({"error": "Email or phone already registered"}), 409
        print(f"Error inserting pending user: {e}")
        return jsonify({"error": "Failed to start registration"}), 500


@app.route('/api/users/login', methods=['POST'])
def login_user():
    """Login with basic validation and password check."""
    data = request.json or {}

    email = (data.get('email') or '').strip()
    password = str(data.get('password') or '')

    errors = []
    if not email or not re.fullmatch(r'[A-Za-z0-9._%+-]+@gmail\.com', email):
        errors.append('Valid Gmail address is required (e.g., user@gmail.com)')
    if not 8 <= len(password) <= 12:
        errors.append('Password must be 8 to 12 characters long')
    if ' ' in password:
        errors.append('Password cannot contain spaces')
    if not re.search(r'[A-Za-z]', password) or not re.search(r'\d', password):
        errors.append('Password must include letters and digits')

    if errors:
        return jsonify({"error": errors}), 400

    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        cursor = connection.cursor(dictionary=True)
        cursor.execute(
            "SELECT user_id, full_name, email, phone, password_hash, role FROM users WHERE email = %s",
            (email,)
        )
        user = cursor.fetchone()

        if not user:
            connection.close()
            return jsonify({"error": "Invalid email or password"}), 401

        if not check_password_hash(user.get('password_hash'), password):
            connection.close()
            return jsonify({"error": "Invalid email or password"}), 401

        # Optional local bypass for OTP flow when SMTP is not configured.
        BYPASS_OTP = os.getenv('BYPASS_OTP', 'False').lower() == 'true'
        
        if BYPASS_OTP:
            connection.close()
            return jsonify({
                "user_id": user.get('user_id'),
                "email": user.get('email'),
                "full_name": user.get('full_name'),
                "phone": user.get('phone'),
                "role": user.get('role'),
                "message": "Login successful (OTP bypassed for testing)",
                "requires_otp": False
            }), 200
        
        otp_ok, otp_error = save_and_email_otp(connection, user.get('user_id'), user.get('email'), user.get('full_name'), purpose='Login')
        connection.close()
        if not otp_ok:
            return jsonify({"error": f"Unable to send OTP: {otp_error}"}), 502

        return jsonify({
            "user_id": user.get('user_id'),
            "email": user.get('email'),
            "full_name": user.get('full_name'),
            "message": "OTP sent to email. Complete verification to finish login.",
            "requires_otp": True
        }), 200

    except Error as e:
        print(f"Error during login: {e}")
        connection.close()
        return jsonify({"error": "Failed to login"}), 500


@app.route('/api/users/resend-otp', methods=['POST'])
def resend_otp():
    """Resend OTP with a minimum 60-second cooldown."""
    data = request.json or {}
    email = (data.get('email') or '').strip()
    purpose = (data.get('purpose') or 'Login').strip() or 'Login'

    if not email or not re.fullmatch(r'[A-Za-z0-9._%+-]+@gmail\.com', email):
        return jsonify({"error": "Valid Gmail address is required"}), 400

    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        if purpose.lower().startswith('reg'):
            pending = pending_registrations.get(email)
            if not pending:
                return jsonify({"error": "No pending registration for this email"}), 404
            last_sent = pending.get('otp_last_sent_at')
            if last_sent:
                elapsed = (datetime.utcnow() - last_sent).total_seconds()
                if elapsed < 60:
                    wait_for = int(60 - elapsed)
                    return jsonify({"error": f"Please wait {wait_for} seconds before requesting another OTP"}), 429

            new_otp = generate_otp()
            pending['otp_code'] = new_otp
            pending['otp_expires_at'] = datetime.utcnow() + timedelta(minutes=OTP_EXPIRES_MINUTES)
            pending['otp_last_sent_at'] = datetime.utcnow()
            email_body = (
                f"Hello {pending.get('full_name') or 'User'},\n\n"
                f"Your Registration OTP is {new_otp}. It is valid for {OTP_EXPIRES_MINUTES} minutes.\n\n"
                "If you did not request this, please ignore the email."
            )
            send_email(email, 'Registration OTP', email_body)
            return jsonify({"message": "OTP resent to your email", "requires_otp": True}), 200

        cursor = connection.cursor(dictionary=True)
        cursor.execute(
            "SELECT user_id AS id, full_name, email, otp_last_sent_at FROM users WHERE email = %s",
            (email,)
        )
        record = cursor.fetchone()

        if not record:
            connection.close()
            return jsonify({"error": "User not found for OTP resend"}), 404

        last_sent = record.get('otp_last_sent_at')
        if last_sent:
            elapsed = (datetime.utcnow() - last_sent).total_seconds()
            if elapsed < 60:
                wait_for = int(60 - elapsed)
                connection.close()
                return jsonify({"error": f"Please wait {wait_for} seconds before requesting another OTP"}), 429

        otp_ok, otp_error = save_and_email_otp(connection, record.get('id'), record.get('email'), record.get('full_name'), purpose=purpose)
        connection.close()
        if not otp_ok:
            return jsonify({"error": f"Unable to send OTP: {otp_error}"}), 502

        return jsonify({"message": "OTP resent to your email", "requires_otp": True}), 200
    except Error as e:
        print(f"Error during OTP resend: {e}")
        connection.close()
        return jsonify({"error": "Failed to resend OTP"}), 500


@app.route('/api/users/verify-otp', methods=['POST'])
def verify_user_otp():
    """Validate OTP sent during registration or login."""
    data = request.json or {}
    email = (data.get('email') or '').strip()
    otp = (data.get('otp') or '').strip()
    purpose = (data.get('purpose') or '').strip().lower()

    if not email or not otp:
        return jsonify({"error": "Email and OTP are required"}), 400

    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        pending = pending_registrations.get(email)
        if pending:
            if pending.get('otp_code') != otp:
                return jsonify({"error": "Invalid OTP"}), 401
            if pending.get('otp_expires_at') < datetime.utcnow():
                return jsonify({"error": "OTP expired"}), 401

            cursor_insert = connection.cursor()
            cursor_insert.execute(
                """
                INSERT INTO users (full_name, email, phone, password_hash, role, otp_code, otp_expires_at, otp_last_sent_at)
                VALUES (%s, %s, %s, %s, %s, NULL, NULL, NULL)
                """,
                (
                    pending.get('full_name'),
                    pending.get('email'),
                    pending.get('phone'),
                    pending.get('password_hash'),
                    pending.get('role')
                )
            )
            connection.commit()
            new_user_id = cursor_insert.lastrowid
            pending_registrations.pop(email, None)
            connection.close()
            return jsonify({
                "user_id": new_user_id,
                "full_name": pending.get('full_name'),
                "email": pending.get('email'),
                "phone": pending.get('phone'),
                "role": pending.get('role'),
                "message": "Registration complete. OTP verified.",
                "is_verified": True
            }), 200

        cursor = connection.cursor(dictionary=True)
        cursor.execute(
            "SELECT user_id, full_name, email, phone, role, otp_code, otp_expires_at FROM users WHERE email = %s",
            (email,)
        )
        user = cursor.fetchone()

        if not user:
            connection.close()
            return jsonify({"error": "User not found"}), 404

        if not user.get('otp_code') or not user.get('otp_expires_at'):
            connection.close()
            return jsonify({"error": "OTP not generated. Please request a new OTP."}), 400

        if user.get('otp_code') != otp:
            connection.close()
            return jsonify({"error": "Invalid OTP"}), 401

        if user.get('otp_expires_at') < datetime.utcnow():
            connection.close()
            return jsonify({"error": "OTP expired"}), 401

        cursor_update = connection.cursor()
        cursor_update.execute(
            "UPDATE users SET otp_code = NULL, otp_expires_at = NULL WHERE user_id = %s",
            (user.get('user_id'),)
        )
        connection.commit()
        connection.close()

        return jsonify({
            "user_id": user.get('user_id'),
            "full_name": user.get('full_name'),
            "email": user.get('email'),
            "phone": user.get('phone'),
            "role": user.get('role'),
            "message": "OTP verified. Login successful.",
            "is_verified": True
        }), 200
    except Error as e:
        print(f"Error during OTP verification: {e}")
        connection.close()
        return jsonify({"error": "Failed to verify OTP"}), 500


@app.route('/api/users/<int:user_id>/change-password', methods=['PUT'])
def change_password(user_id):
    """Change user password - requires current password verification"""
    data = request.json or {}
    
    current_password = str(data.get('current_password') or '').strip()
    new_password = str(data.get('new_password') or '').strip()
    
    # Validate inputs
    errors = []
    if not current_password:
        errors.append('Current password is required')
    if not new_password:
        errors.append('New password is required')
    if not 8 <= len(new_password) <= 12:
        errors.append('New password must be 8 to 12 characters long')
    if ' ' in new_password:
        errors.append('New password cannot contain spaces')
    if not re.search(r'[A-Za-z]', new_password) or not re.search(r'\d', new_password):
        errors.append('New password must include letters and digits')
    
    if errors:
        return jsonify({"error": errors}), 400
    
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        cursor = connection.cursor(dictionary=True)
        
        # Get current user data
        cursor.execute(
            "SELECT user_id, password_hash FROM users WHERE user_id = %s",
            (user_id,)
        )
        user = cursor.fetchone()
        
        if not user:
            connection.close()
            return jsonify({"error": "User not found"}), 404
        
        # Verify current password
        if not check_password_hash(user['password_hash'], current_password):
            connection.close()
            return jsonify({"error": "Current password is incorrect"}), 401
        
        # Hash new password
        new_password_hash = generate_password_hash(new_password)
        
        # Update password in database
        cursor.execute(
            "UPDATE users SET password_hash = %s WHERE user_id = %s",
            (new_password_hash, user_id)
        )
        connection.commit()
        connection.close()
        
        return jsonify({
            "message": "Password changed successfully"
        }), 200
        
    except Error as e:
        print(f"Error changing password: {e}")
        connection.close()
        return jsonify({"error": "Failed to change password"}), 500


@app.route('/api/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    db_status = "connected" if get_db_connection() else "disconnected"
    return jsonify({
        "status": "healthy",
        "message": "Property API is running",
        "database": db_status
    })


# ==================== ADMIN ROUTES ====================

@app.route('/api/admin/login', methods=['POST'])
def admin_login():
    """Admin login - validates email and password"""
    connection = get_db_connection()
    if connection is None:
        return jsonify({'error': 'Database connection failed'}), 500
    
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    cursor = connection.cursor(dictionary=True)
    
    cursor.execute("SELECT * FROM admins WHERE email = %s", (email,))
    admin = cursor.fetchone()
    
    cursor.close()
    connection.close()

    if admin and check_password_hash(admin['password_hash'], password):
        try:
            conn2 = get_db_connection()
            if conn2:
                cur2 = conn2.cursor()
                cur2.execute("UPDATE admins SET updated_at = NOW() WHERE admin_id = %s", (admin['admin_id'],))
                conn2.commit()
                conn2.close()
        except:
            pass 

        return jsonify({
            'message': 'Login successful',
            'admin': {
                'id': admin['admin_id'],
                'username': admin['username'],
                'email': admin['email'],
                'role': admin['role']
            }
        }), 200
    else:
        return jsonify({'error': 'Invalid email or password'}), 401


@app.route('/api/properties/<int:id>', methods=['PUT', 'PATCH'])
def update_property(id):
    """Update property details (Admin operation)"""
    connection = get_db_connection()
    if connection is None:
        return jsonify({'error': 'Database connection failed'}), 500
    
    data = request.get_json()
    cursor = connection.cursor()
    
    try:
        sql = """
            UPDATE properties 
            SET title = %s, price = %s, property_category = %s, availability_status = %s
            WHERE property_id = %s
        """
        cursor.execute(sql, (
            data.get('title'),
            data.get('price'),
            data.get('property_category'),
            data.get('availability_status'),
            id
        ))
        connection.commit()
        cursor.close()
        connection.close()
        return jsonify({'message': 'Property updated successfully'})
    except mysql.connector.Error as err:
        return jsonify({'error': str(err)}), 500


@app.route('/api/properties/<int:id>', methods=['DELETE'])
def delete_property(id):
    """Delete a property (Admin operation)"""
    connection = get_db_connection()
    if connection is None:
        return jsonify({'error': 'Database connection failed'}), 500
    
    cursor = connection.cursor()
    
    try:
        cursor.execute("DELETE FROM properties WHERE property_id = %s", (id,))
        connection.commit()
        cursor.close()
        connection.close()
        return jsonify({'message': 'Property deleted successfully'})
    except mysql.connector.Error as err:
        return jsonify({'error': str(err)}), 500


@app.route('/api/stats', methods=['GET'])
def get_stats():
    """Get dashboard statistics"""
    connection = get_db_connection()
    if connection is None:
        return jsonify({'error': 'Database connection failed'}), 500
    
    cursor = connection.cursor(dictionary=True)
    stats = {}
    
    try:
        cursor.execute("SELECT COUNT(*) as count FROM properties")
        stats['properties'] = cursor.fetchone()['count']
        
        cursor.execute("SELECT SUM(price) as total FROM properties")
        res = cursor.fetchone()
        stats['volume'] = res['total'] if res['total'] else 0
        
        cursor.execute("SELECT COUNT(*) as count FROM owners WHERE role='Agent'")
        stats['agents'] = cursor.fetchone()['count']

        cursor.execute("SELECT COUNT(*) as count FROM enquiries")
        stats['enquiries'] = cursor.fetchone()['count']
    except Exception as e:
        print("Stats Error:", e)
        stats = {'properties': 0, 'volume': 0, 'agents': 0, 'enquiries': 0}

    cursor.close()
    connection.close()
    return jsonify(stats)


@app.route('/api/enquiries', methods=['GET', 'POST'])
def enquiries():
    """Get all enquiries or create a new enquiry"""
    if request.method == 'POST':
        data = request.json or {}
        
        property_id = data.get('property_id')
        name = (data.get('name') or '').strip()
        email = (data.get('email') or '').strip()
        phone = (data.get('phone') or '').strip()
        message = (data.get('message') or '').strip()
        
        errors = []
        if not name:
            errors.append('Name is required')
        if not email:
            errors.append('Email is required')
        if not phone:
            errors.append('Phone number is required')
        if not re.fullmatch(r'[9876][0-9]{9}', phone):
            errors.append('Phone must be 10 digits and start with 9, 8, 7, or 6')
        if not message:
            errors.append('Message is required')
        
        if errors:
            return jsonify({'error': ', '.join(errors)}), 400
        
        connection = get_db_connection()
        if connection is None:
            return jsonify({'error': 'Database connection failed'}), 500
        
        cursor = connection.cursor()
        
        try:
            sql = """
                INSERT INTO enquiries (property_id, name, email, phone, message, created_at)
                VALUES (%s, %s, %s, %s, %s, NOW())
            """
            cursor.execute(sql, (property_id, name, email, phone, message))
            connection.commit()
            enquiry_id = cursor.lastrowid
            
            cursor.close()
            connection.close()
            
            return jsonify({
                'message': 'Enquiry submitted successfully',
                'enquiry_id': enquiry_id
            }), 201
        except mysql.connector.Error as err:
            cursor.close()
            connection.close()
            return jsonify({'error': str(err)}), 500
    
    else:
        connection = get_db_connection()
        if connection is None:
            return jsonify({'error': 'Database connection failed'}), 500
        
        cursor = connection.cursor(dictionary=True)
        
        try:
            sql = """
                SELECT e.*, p.title as property_title
                FROM enquiries e 
                LEFT JOIN properties p ON e.property_id = p.property_id 
                ORDER BY e.created_at DESC
            """
            cursor.execute(sql)
            enquiries = cursor.fetchall()
        except Exception as err:
            print(f"Error fetching enquiries: {err}")
            enquiries = []
        
        cursor.close()
        connection.close()
        return jsonify(enquiries)


@app.route('/api/enquiries/<int:id>', methods=['PUT', 'PATCH'])
def update_enquiry(id):
    """Update enquiry status"""
    connection = get_db_connection()
    if connection is None:
        return jsonify({'error': 'Database connection failed'}), 500
    
    data = request.get_json()
    cursor = connection.cursor()
    
    try:
        cursor.execute("UPDATE enquiries SET status = %s WHERE enquiry_id = %s", 
                      (data.get('status'), id))
        connection.commit()
        cursor.close()
        connection.close()
        return jsonify({'message': 'Status updated'})
    except mysql.connector.Error as err:
        return jsonify({'error': str(err)}), 500


@app.route('/api/owners', methods=['GET'])
def get_owners():
    """Get all owners and agents"""
    connection = get_db_connection()
    if connection is None:
        return jsonify({'error': 'Database connection failed'}), 500
    
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT * FROM owners ORDER BY owner_id ASC")
    owners = cursor.fetchall()
    cursor.close()
    connection.close()
    return jsonify(owners)

@app.route('/api/chart-data', methods=['GET'])
def get_chart_data():
    """Get aggregated data for all 4 admin dashboard charts"""
    connection = get_db_connection()
    if connection is None:
        return jsonify({'error': 'Database connection failed'}), 500
    
    cursor = connection.cursor(dictionary=True)
    chart_data = {}

    try:
        cursor.execute("""
            SELECT pl.area, COUNT(p.property_id) as count 
            FROM properties p
            JOIN property_location pl ON p.property_id = pl.property_id
            GROUP BY pl.area
            ORDER BY count DESC
            LIMIT 10
        """)
        chart_data['area_popularity'] = cursor.fetchall()

        cursor.execute("""
            SELECT property_category, COUNT(*) as count 
            FROM properties 
            GROUP BY property_category
        """)
        chart_data['property_types'] = cursor.fetchall()

        cursor.execute("""
            SELECT o.name, COUNT(po.property_id) as count
            FROM owners o
            JOIN property_owner po ON o.owner_id = po.owner_id
            WHERE o.role = 'Agent'
            GROUP BY o.owner_id, o.name
            ORDER BY count DESC
            LIMIT 10
        """)
        chart_data['agent_performance'] = cursor.fetchall()

        cursor.execute("""
            SELECT pl.area, AVG(p.price) as avg_price
            FROM properties p
            JOIN property_location pl ON p.property_id = pl.property_id
            GROUP BY pl.area
            ORDER BY avg_price DESC
            LIMIT 10
        """)
        chart_data['expensive_areas'] = cursor.fetchall()

    except Exception as e:
        print(f"Error fetching chart data: {e}")
        chart_data = {
            'area_popularity': [], 
            'property_types': [], 
            'agent_performance': [], 
            'expensive_areas': []
        }

    cursor.close()
    connection.close()
    return jsonify(chart_data)


# ==================== USER ACTIVITY ROUTES (NEW) ====================

@app.route('/api/users/<int:user_id>/activity', methods=['GET'])
def get_user_activity(user_id):
    """Fetch user's saved, recent, and contacted properties."""
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        cursor = connection.cursor(dictionary=True)
        
        # Get all interactions for this user
        query = "SELECT property_id, interaction_type FROM user_interactions WHERE user_id = %s"
        cursor.execute(query, (user_id,))
        results = cursor.fetchall()
        
        # Organize data for frontend
        activity_data = {
            "saved": [],
            "recent": [],
            "contacted": []
        }
        
        for row in results:
            p_id = str(row['property_id']) # Convert to string to match frontend expectations
            i_type = row['interaction_type']
            if i_type in activity_data:
                activity_data[i_type].append(p_id)

        connection.close()
        return jsonify(activity_data), 200

    except Error as e:
        print(f"Error fetching user activity: {e}")
        if connection: connection.close()
        return jsonify({"error": str(e)}), 500


@app.route('/api/users/activity/update', methods=['POST'])
def update_user_activity():
    """Add, Remove (toggle), or Update user interactions."""
    data = request.json or {}
    user_id = data.get('user_id')
    property_id = data.get('property_id')
    action = data.get('action') # 'saved', 'recent', or 'contacted'

    if not all([user_id, property_id, action]):
        return jsonify({"error": "Missing required fields"}), 400

    if action not in ['saved', 'recent', 'contacted']:
        return jsonify({"error": "Invalid action type"}), 400

    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        cursor = connection.cursor()

        if action == 'saved':
            # TOGGLE LOGIC: If it exists, delete it. If not, add it.
            check_query = "SELECT interaction_id FROM user_interactions WHERE user_id = %s AND property_id = %s AND interaction_type = 'saved'"
            cursor.execute(check_query, (user_id, property_id))
            existing = cursor.fetchone()

            if existing:
                # Remove from saved
                delete_query = "DELETE FROM user_interactions WHERE interaction_id = %s"
                cursor.execute(delete_query, (existing[0],))
                message = "Property removed from saved"
            else:
                # Add to saved
                insert_query = "INSERT INTO user_interactions (user_id, property_id, interaction_type) VALUES (%s, %s, 'saved')"
                cursor.execute(insert_query, (user_id, property_id))
                message = "Property saved"

        elif action == 'recent':
            # RECENT LOGIC: Update timestamp if exists, or insert new
            insert_query = """
            INSERT INTO user_interactions (user_id, property_id, interaction_type, created_at) 
            VALUES (%s, %s, 'recent', NOW()) 
            ON DUPLICATE KEY UPDATE created_at = NOW()
            """
            cursor.execute(insert_query, (user_id, property_id))
            message = "Recently viewed updated"

        elif action == 'contacted':
            # CONTACT LOGIC: Insert if not exists
            insert_query = """
            INSERT IGNORE INTO user_interactions (user_id, property_id, interaction_type) 
            VALUES (%s, %s, 'contacted')
            """
            cursor.execute(insert_query, (user_id, property_id))
            message = "Contact recorded"

        connection.commit()
        connection.close()
        return jsonify({"message": message}), 200

    except Error as e:
        print(f"Error updating activity: {e}")
        if connection: 
            connection.rollback()
            connection.close()
        return jsonify({"error": str(e)}), 500


# ==================== USER ACTIVITY API (SAVED, VIEWED, CONTACTED) ====================

@app.route('/api/users/<int:user_id>/saved-properties', methods=['GET'])
def get_saved_properties(user_id):
    """Get all saved properties for a user with full property details."""
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        cursor = connection.cursor(dictionary=True)
        query = """
        SELECT 
            sp.saved_at as activityDate,
            p.property_id as id,
            p.title,
            p.property_type as type,
            p.property_category as category,
            p.listing_type,
            p.price,
            p.area_sqft as area,
            p.bedrooms,
            COALESCE(pl.area, pl.city, '') as location,
            COALESCE(pi.image_url, '') as image
        FROM saved_properties sp
        JOIN properties p ON sp.property_id = p.property_id
        LEFT JOIN property_location pl ON p.property_id = pl.property_id
        LEFT JOIN property_images pi ON p.property_id = pi.property_id AND pi.is_primary = 1
        WHERE sp.user_id = %s
        ORDER BY sp.saved_at DESC
        """
        cursor.execute(query, (user_id,))
        properties = cursor.fetchall()
        connection.close()
        
        # Format the response
        for prop in properties:
            prop['area'] = f"{prop['area']} sq.ft" if prop['area'] else "N/A"
            
        return jsonify(properties), 200
    except Error as e:
        print(f"Error fetching saved properties: {e}")
        if connection: connection.close()
        return jsonify({"error": str(e)}), 500


@app.route('/api/users/<int:user_id>/saved-properties', methods=['POST'])
def add_saved_property(user_id):
    """Add a property to user's saved list."""
    data = request.json or {}
    property_id = data.get('property_id')
    
    if not property_id:
        return jsonify({"error": "property_id is required"}), 400
    
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        cursor = connection.cursor()
        
        # Check if already saved
        check_query = "SELECT id FROM saved_properties WHERE user_id = %s AND property_id = %s"
        cursor.execute(check_query, (user_id, property_id))
        existing = cursor.fetchone()
        
        if existing:
            connection.close()
            return jsonify({"message": "Property already saved", "already_saved": True}), 200
        
        # Insert new saved property
        insert_query = "INSERT INTO saved_properties (user_id, property_id) VALUES (%s, %s)"
        cursor.execute(insert_query, (user_id, property_id))
        connection.commit()
        connection.close()
        
        return jsonify({"message": "Property saved successfully"}), 201
    except Error as e:
        print(f"Error saving property: {e}")
        if connection:
            connection.rollback()
            connection.close()
        return jsonify({"error": str(e)}), 500


@app.route('/api/users/<int:user_id>/saved-properties/<int:property_id>', methods=['DELETE'])
def remove_saved_property(user_id, property_id):
    """Remove a property from user's saved list."""
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        cursor = connection.cursor()
        delete_query = "DELETE FROM saved_properties WHERE user_id = %s AND property_id = %s"
        cursor.execute(delete_query, (user_id, property_id))
        connection.commit()
        
        if cursor.rowcount == 0:
            connection.close()
            return jsonify({"error": "Property not found in saved list"}), 404
        
        connection.close()
        return jsonify({"message": "Property removed from saved list"}), 200
    except Error as e:
        print(f"Error removing saved property: {e}")
        if connection:
            connection.rollback()
            connection.close()
        return jsonify({"error": str(e)}), 500


@app.route('/api/users/<int:user_id>/recently-viewed', methods=['GET'])
def get_recently_viewed(user_id):
    """Get recently viewed properties for a user."""
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        cursor = connection.cursor(dictionary=True)
        query = """
        SELECT 
            rv.viewed_at as activityDate,
            p.property_id as id,
            p.title,
            p.property_type as type,
            p.property_category as category,
            p.listing_type,
            p.price,
            p.area_sqft as area,
            p.bedrooms,
            COALESCE(pl.area, pl.city, '') as location,
            COALESCE(pi.image_url, '') as image
        FROM recently_viewed rv
        JOIN properties p ON rv.property_id = p.property_id
        LEFT JOIN property_location pl ON p.property_id = pl.property_id
        LEFT JOIN property_images pi ON p.property_id = pi.property_id AND pi.is_primary = 1
        WHERE rv.user_id = %s
        ORDER BY rv.viewed_at DESC
        LIMIT 50
        """
        cursor.execute(query, (user_id,))
        properties = cursor.fetchall()
        connection.close()
        
        # Format the response
        for prop in properties:
            prop['area'] = f"{prop['area']} sq.ft" if prop['area'] else "N/A"
            
        return jsonify(properties), 200
    except Error as e:
        print(f"Error fetching recently viewed: {e}")
        if connection: connection.close()
        return jsonify({"error": str(e)}), 500


@app.route('/api/users/<int:user_id>/recently-viewed', methods=['POST'])
def add_recently_viewed(user_id):
    """Add or update a property in recently viewed list."""
    data = request.json or {}
    property_id = data.get('property_id')
    
    if not property_id:
        return jsonify({"error": "property_id is required"}), 400
    
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        cursor = connection.cursor()
        
        # Insert or update the viewed timestamp
        query = """
        INSERT INTO recently_viewed (user_id, property_id, viewed_at) 
        VALUES (%s, %s, NOW()) 
        ON DUPLICATE KEY UPDATE viewed_at = NOW()
        """
        cursor.execute(query, (user_id, property_id))
        connection.commit()
        connection.close()
        
        return jsonify({"message": "Recently viewed updated"}), 200
    except Error as e:
        print(f"Error updating recently viewed: {e}")
        if connection:
            connection.rollback()
            connection.close()
        return jsonify({"error": str(e)}), 500


@app.route('/api/users/<int:user_id>/contacted-properties', methods=['GET'])
def get_contacted_properties(user_id):
    """Get contacted properties for a user."""
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503

    try:
        cursor = connection.cursor(dictionary=True)
        query = """
        SELECT 
            cp.contacted_at as activityDate,
            p.property_id as id,
            p.title,
            p.property_type as type,
            p.property_category as category,
            p.listing_type,
            p.price,
            p.area_sqft as area,
            p.bedrooms,
            COALESCE(pl.area, pl.city, '') as location,
            COALESCE(pi.image_url, '') as image
        FROM contacted_properties cp
        JOIN properties p ON cp.property_id = p.property_id
        LEFT JOIN property_location pl ON p.property_id = pl.property_id
        LEFT JOIN property_images pi ON p.property_id = pi.property_id AND pi.is_primary = 1
        WHERE cp.user_id = %s
        ORDER BY cp.contacted_at DESC
        """
        cursor.execute(query, (user_id,))
        properties = cursor.fetchall()
        connection.close()
        
        # Format the response
        for prop in properties:
            prop['area'] = f"{prop['area']} sq.ft" if prop['area'] else "N/A"
            
        return jsonify(properties), 200
    except Error as e:
        print(f"Error fetching contacted properties: {e}")
        if connection: connection.close()
        return jsonify({"error": str(e)}), 500


@app.route('/api/users/<int:user_id>/contacted-properties', methods=['POST'])
def add_contacted_property(user_id):
    """Add a property to contacted list."""
    data = request.json or {}
    property_id = data.get('property_id')
    
    if not property_id:
        return jsonify({"error": "property_id is required"}), 400
    
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        cursor = connection.cursor()
        
        # Insert if not exists
        query = """
        INSERT INTO contacted_properties (user_id, property_id) 
        VALUES (%s, %s)
        ON DUPLICATE KEY UPDATE contacted_at = contacted_at
        """
        cursor.execute(query, (user_id, property_id))
        connection.commit()
        connection.close()
        
        return jsonify({"message": "Contact recorded"}), 200
    except Error as e:
        print(f"Error recording contact: {e}")
        if connection:
            connection.rollback()
            connection.close()
        return jsonify({"error": str(e)}), 500


@app.route('/api/users/<int:user_id>/contacted-properties/<int:property_id>', methods=['DELETE'])
def remove_contacted_property(user_id, property_id):
    """Remove a property from contacted list."""
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database unavailable"}), 503
    
    try:
        cursor = connection.cursor()
        delete_query = "DELETE FROM contacted_properties WHERE user_id = %s AND property_id = %s"
        cursor.execute(delete_query, (user_id, property_id))
        connection.commit()
        
        if cursor.rowcount == 0:
            connection.close()
            return jsonify({"error": "Property not found in contacted list"}), 404
        
        connection.close()
        return jsonify({"message": "Property removed from contacted list"}), 200
    except Error as e:
        print(f"Error removing contacted property: {e}")
        if connection:
            connection.rollback()
            connection.close()
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    import sys
    
    # Check if running with utility command
    if len(sys.argv) > 1:
        command = sys.argv[1].lower()
        
        if command == 'hash':
            hash_admin_passwords()
        elif command == 'test':
            test_database_connection()
        elif command == 'help':
            print("\n🔧 Admin App Utility Commands:")
            print("=" * 50)
            print("python app.py hash   - Hash admin passwords")
            print("python app.py test   - Test database connection and structure")
            print("python app.py        - Start Flask server")
            print("=" * 50)
        else:
            print(f"❌ Unknown command: {command}")
            print("Run 'python app.py help' for available commands")
    else:
        # Initialize database on startup
        init_database()
        port = int(os.environ.get('PORT', 5000))
        print("🚀 Flask Server is running on http://localhost:" + str(port))
        print("📊 Admin credentials:")
        for admin in ADMINS_DATA:
            print(f"   Email: {admin['email']} | Password: {admin['password']}")
        print("\n💡 Tip: Run 'python app.py help' to see utility commands")
        app.run(debug=True, host='0.0.0.0', port=port)