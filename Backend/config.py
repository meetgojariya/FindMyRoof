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
# Admin credentials with plain text passwords (for initial setup)
ADMINS_DATA = [
    {
        'username': 'meet_gojariya',
        'email': 'meetgojariya214@gmail.com',
        'password': 'meet@2747',
        'role': 'admin'
    },
    {
        'username': 'krish_tarpara',
        'email': 'tarparakrish0903@gmail.com',
        'password': 'krish@0918',
        'role': 'admin'
    },
    {
        'username': 'meet_senjaliya',
        'email': 'meetsenjaliya@gmail.com',
        'password': 'meets@123',
        'role': 'admin'
    }
]
