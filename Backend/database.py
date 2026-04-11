"""
Database connection and query functions for FindMyRoof application.
Contains functions for DB connection, initialization, and common queries.
"""

import mysql.connector
from mysql.connector import Error
from werkzeug.security import generate_password_hash

from config import DB_CONFIG, ADMINS_DATA


def get_db_connection():
    """Create and return MySQL database connection."""
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        return connection
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None


def init_database():
    """Ping database connection without altering schema."""
    connection = get_db_connection()
    if not connection:
        print("Database connection failed. Skipping database init.")
        return False

    connection.close()
    return True


def fetch_properties_from_db():
    """Fetch all properties from database with location and images."""
    connection = get_db_connection()
    if not connection:
        return []

    try:
        cursor = connection.cursor(dictionary=True)
        query = """
        SELECT
            p.property_id, p.title, p.description, p.property_type, p.property_category,
            p.listing_type, p.sale_type, p.price, p.area_sqft,
            p.bedrooms, p.furnishing_status, p.property_age, p.facing,
            COALESCE(pi.image_url, '') AS image_url,
            COALESCE(pl.area, pl.city, '') AS location,
            COALESCE(pl.pincode, '') AS pincode,
            COALESCE(o.role, '') AS listed_by,
            COALESCE(am.amenities, '') AS amenities
        FROM properties p
        LEFT JOIN (
            SELECT property_id, MAX(image_url) AS image_url
            FROM property_images
            WHERE is_primary = 1
            GROUP BY property_id
        ) pi ON pi.property_id = p.property_id
        LEFT JOIN (
            SELECT property_id, MAX(area) AS area, MAX(city) AS city, MAX(pincode) AS pincode
            FROM property_location
            GROUP BY property_id
        ) pl ON pl.property_id = p.property_id
        LEFT JOIN (
            SELECT po.property_id, MAX(o.role) AS role
            FROM property_owner po
            LEFT JOIN owners o ON o.owner_id = po.owner_id
            GROUP BY po.property_id
        ) o ON o.property_id = p.property_id
        LEFT JOIN (
            SELECT pa.property_id, GROUP_CONCAT(DISTINCT a.amenity_name ORDER BY a.amenity_name SEPARATOR ', ') AS amenities
            FROM property_amenities pa
            LEFT JOIN amenities a ON a.amenity_id = pa.amenity_id
            GROUP BY pa.property_id
        ) am ON am.property_id = p.property_id
        ORDER BY p.created_at DESC
        """
        cursor.execute(query)
        properties = cursor.fetchall()

        def map_row(row):
            amenities_str = row.get("amenities") or ""
            amenities_list = [a.strip() for a in amenities_str.split(',')] if amenities_str else []
            
            return {
                "id": row.get("property_id"),
                "name": row.get("title"),
                "location": row.get("location") or "",
                "price": str(row.get("price") or ""),
                "image": row.get("image_url") or "",
                "type": (row.get("listing_type") or "").lower(),
                "bhk": f"{row.get('bedrooms')} BHK" if row.get("bedrooms") is not None else "",
                "area": f"{row.get('area_sqft')} sq ft" if row.get("area_sqft") is not None else "",
                "furnish": row.get("furnishing_status") or "",
                "description": row.get("description") or "",
                "property_type": row.get("property_type") or "",
                "category": row.get("property_category") or "",
                "sale_type": (row.get("sale_type") or "").lower(),
                "property_age": row.get("property_age") or "",
                "facing": (row.get("facing") or "").lower(),
                "furnishing": (row.get("furnishing_status") or "").lower(),
                "listed_by": (row.get("listed_by") or "").lower(),
                "pincode": row.get("pincode") or "",
                "amenities": amenities_list
            }

        connection.close()
        return [map_row(prop) for prop in properties]
    except Error as e:
        print(f"Error fetching from database: {e}")
        return []


# ==================== ADMIN UTILITY FUNCTIONS ====================

def create_admins_table(connection):
    """Create the admins table if it doesn't exist"""
    cursor = connection.cursor()
    try:
        sql = """
        CREATE TABLE IF NOT EXISTS `admins` (
            `admin_id` INT(11) NOT NULL AUTO_INCREMENT,
            `username` VARCHAR(100) NOT NULL UNIQUE,
            `email` VARCHAR(150) NOT NULL UNIQUE,
            `password_hash` VARCHAR(255) NOT NULL,
            `role` ENUM('admin', 'superadmin') DEFAULT 'admin',
            `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            PRIMARY KEY (`admin_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
        """
        cursor.execute(sql)
        connection.commit()
        print("✅ Admins table created successfully!")
    except Error as err:
        if "already exists" in str(err):
            print("✅ Admins table already exists")
        else:
            print(f"❌ Error creating admins table: {err}")
    finally:
        cursor.close()


def insert_or_update_admins(connection):
    """Insert or update admin records with hashed passwords"""
    cursor = connection.cursor(dictionary=True)
    
    for admin in ADMINS_DATA:
        password_hash = generate_password_hash(admin['password'])
        
        try:
            cursor.execute(
                "SELECT admin_id FROM admins WHERE email = %s",
                (admin['email'],)
            )
            existing = cursor.fetchone()
            
            if existing:
                cursor.execute(
                    """UPDATE admins 
                       SET password_hash = %s, username = %s, role = %s, updated_at = NOW()
                       WHERE email = %s""",
                    (password_hash, admin['username'], admin['role'], admin['email'])
                )
                print(f"✅ Updated admin: {admin['email']}")
            else:
                cursor.execute(
                    """INSERT INTO admins (username, email, password_hash, role)
                       VALUES (%s, %s, %s, %s)""",
                    (admin['username'], admin['email'], password_hash, admin['role'])
                )
                print(f"✅ Added admin: {admin['email']}")
            
            connection.commit()
            
        except Error as err:
            print(f"❌ Error with admin {admin['email']}: {err}")
            connection.rollback()
    
    cursor.close()


def hash_admin_passwords():
    """Hash admin passwords and create/update the admins table"""
    print("🔐 Password Hashing and Admin Setup Script")
    print("=" * 50)
    
    try:
        connection = get_db_connection()
        if not connection:
            print("❌ Database connection failed")
            return
            
        print("✅ Connected to database successfully")
        
        create_admins_table(connection)
        print("\n📝 Processing admin accounts...")
        insert_or_update_admins(connection)
        
        connection.close()
        print("\n✅ All done! Admin passwords are now securely hashed.")
        print("\n📌 Admin Credentials (use these to login):")
        print("-" * 50)
        for admin in ADMINS_DATA:
            print(f"Email: {admin['email']}")
            print(f"Password: {admin['password']}")
            print()
        
    except Error as err:
        print(f"❌ Database Error: {err}")
    except Exception as e:
        print(f"❌ Error: {e}")


def test_database_connection():
    """Test database connection and verify tables structure"""
    print("🔍 Database Connection Test")
    print("=" * 50)
    
    try:
        connection = get_db_connection()
        if not connection:
            print("❌ Database connection failed")
            return
        
        print("✅ Connected to database successfully")
        cursor = connection.cursor()
        
        # Check properties table structure
        cursor.execute('DESCRIBE properties')
        print('\n📋 Properties table columns:')
        for row in cursor.fetchall():
            print(f"  {row[0]} - {row[1]}")
        
        # Check if property_id exists
        cursor.execute('SHOW COLUMNS FROM properties LIKE "property_id"')
        result = cursor.fetchone()
        print(f'\n✓ property_id column exists: {result is not None}')
        
        # Check if id exists
        cursor.execute('SHOW COLUMNS FROM properties LIKE "id"')
        result = cursor.fetchone()
        print(f'✓ id column exists: {result is not None}')
        
        try:
            sql = """
                SELECT e.*, p.title as property_title
                FROM enquiries e 
                LEFT JOIN properties p ON e.property_id = p.property_id 
                ORDER BY e.created_at DESC
                LIMIT 3
            """
            cursor.execute(sql)
            results = cursor.fetchall()
            print(f'\n✅ JOIN query returned {len(results)} rows')
            if results:
                print('First result preview:')
                print(f'  Enquiry ID: {results[0][0]}')
                print(f'  Property Title: {results[0][-1]}')
        except Exception as e:
            print(f'❌ JOIN query error: {e}')
        
        cursor.close()
        connection.close()
        print("\n✅ Database test completed successfully")
        
    except Error as err:
        print(f"❌ Database Error: {err}")
    except Exception as e:
        print(f"❌ Error: {e}")
