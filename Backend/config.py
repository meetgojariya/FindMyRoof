"""
Configuration settings for FindMyRoof application.
Contains all environment variables, database config, email settings, and admin credentials.
"""

import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# ==================== DATABASE CONFIGURATION ====================
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'database': os.getenv('DB_NAME', 'findmyroof_db'),
    'user': os.getenv('DB_USER', 'root'),
    'password': os.getenv('DB_PASSWORD', '')
}

# ==================== EMAIL CONFIGURATION ====================
EMAIL_ADDRESS = os.getenv('EMAIL_ADDRESS', 'findmyroof1@gmail.com')
EMAIL_PASSWORD = os.getenv('EMAIL_PASSWORD', '')
SMTP_SERVER = os.getenv('SMTP_SERVER', 'smtp.gmail.com')
SMTP_PORT = int(os.getenv('SMTP_PORT', '587'))
SMTP_USE_TLS = os.getenv('SMTP_USE_TLS', 'True').lower() == 'true'

# ==================== OTP CONFIGURATION ====================
OTP_EXPIRES_MINUTES = int(os.getenv('OTP_EXPIRES_MINUTES', '2'))
OTP_LENGTH = 6

# ==================== ADMIN CREDENTIALS ====================
def _load_admins_data():
    """Load admin credentials from environment variables."""
    return [
        {
            'username': os.getenv('ADMIN_1_USERNAME', 'admin_one'),
            'email': os.getenv('ADMIN_1_EMAIL', 'admin1@example.com'),
            'password': os.getenv('ADMIN_1_PASSWORD', ''),
            'role': os.getenv('ADMIN_1_ROLE', 'admin')
        },
        {
            'username': os.getenv('ADMIN_2_USERNAME', 'admin_two'),
            'email': os.getenv('ADMIN_2_EMAIL', 'admin2@example.com'),
            'password': os.getenv('ADMIN_2_PASSWORD', ''),
            'role': os.getenv('ADMIN_2_ROLE', 'admin')
        },
        {
            'username': os.getenv('ADMIN_3_USERNAME', 'admin_three'),
            'email': os.getenv('ADMIN_3_EMAIL', 'admin3@example.com'),
            'password': os.getenv('ADMIN_3_PASSWORD', ''),
            'role': os.getenv('ADMIN_3_ROLE', 'admin')
        }
    ]


ADMINS_DATA = _load_admins_data()
