"""
Utility helper functions for FindMyRoof application.
Contains functions for OTP generation, email sending, and other common utilities.
"""

import random
import smtplib
from datetime import datetime, timedelta
from email.message import EmailMessage

from config import (
    EMAIL_ADDRESS, EMAIL_PASSWORD, SMTP_SERVER, SMTP_PORT, 
    SMTP_USE_TLS, OTP_EXPIRES_MINUTES, OTP_LENGTH
)


def generate_otp(length: int = OTP_LENGTH) -> str:
    """Generate a random numeric OTP of specified length."""
    return ''.join(random.choices('0123456789', k=length))


def send_email(to_email: str, subject: str, body: str):
    """Send email using SMTP with improved error handling."""
    if not all([SMTP_SERVER, SMTP_PORT, EMAIL_ADDRESS, EMAIL_PASSWORD]):
        raise RuntimeError('SMTP configuration is missing')

    try:
        message = EmailMessage()
        message['Subject'] = subject
        message['From'] = EMAIL_ADDRESS
        message['To'] = to_email
        message.set_content(body)

        print(f"Attempting to send email to: {to_email}")
        print(f"Subject: {subject}")
        print(f"SMTP Server: {SMTP_SERVER}:{SMTP_PORT}")
        
        with smtplib.SMTP(SMTP_SERVER, int(SMTP_PORT), timeout=30) as server:
            server.set_debuglevel(0)  # Set to 1 for detailed SMTP debugging
            if SMTP_USE_TLS:
                server.starttls()
            server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
            server.send_message(message)
            
        print(f"✓ Email sent successfully to: {to_email}")
        
    except smtplib.SMTPAuthenticationError as e:
        print(f"✗ SMTP Authentication Error: {e}")
        print("Check if Gmail App Password is correct and 2FA is enabled")
        raise
    except smtplib.SMTPException as e:
        print(f"✗ SMTP Error: {e}")
        raise
    except Exception as e:
        print(f"✗ General Error sending email: {e}")
        raise


def save_and_email_otp(connection, user_id: int, email: str, full_name: str, purpose: str = 'Login'):
    """Persist an OTP for the user and dispatch it over email."""
    if not connection:
        return False, 'Database unavailable'

    otp = generate_otp()
    now_utc = datetime.utcnow()
    expires_at = now_utc + timedelta(minutes=OTP_EXPIRES_MINUTES)

    try:
        cursor = connection.cursor()
        cursor.execute(
            "UPDATE users SET otp_code = %s, otp_expires_at = %s, otp_last_sent_at = %s WHERE user_id = %s",
            (otp, expires_at, now_utc, user_id)
        )
        email_body = (
            f"Hi {full_name or 'User'},\n\n"
            f"Your One-Time Password (OTP) for {purpose} is:\n\n"
            f"👉 {otp} 👈\n\n"
            f"This OTP is valid for {OTP_EXPIRES_MINUTES} minutes.\n"
            "Please do not share this code with anyone for security reasons.\n\n"
            "If you did not request this OTP, you can safely ignore this email.\n\n"
            "Regards,\n"
            "FindMyRoof Team\n"
        )
        send_email(email, f'{purpose} OTP', email_body)
        connection.commit()
        return True, None
    except Exception as e:
        try:
            connection.rollback()
        except Exception:
            pass
        print(f"Error during OTP generation/email: {e}")
        return False, str(e)
