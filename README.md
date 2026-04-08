# FindMyRoof

A comprehensive web platform for property rental and management. Users can browse properties, register accounts, and administrators can manage listings with an intuitive dashboard.

## Features

- **Browse Properties**: View available rental properties with detailed information
- **User Authentication**: Secure registration and login with OTP verification
- **Admin Dashboard**: Manage properties, users, and bookings
- **Price Estimator**: Calculate property prices based on various factors
- **EMI Calculator**: Calculate monthly EMI for property loans
- **Contact Form**: Get in touch with support team
- **Responsive Design**: Works seamlessly on desktop and mobile devices

## Tech Stack

### Frontend
- HTML5
- CSS3
- JavaScript

### Backend
- **Framework**: Flask (Python)
- **Database**: MySQL
- **Authentication**: Password hashing with Werkzeug
- **Email**: SMTP with Gmail
- **CORS**: Flask-CORS for cross-origin requests

### Dependencies
- Flask 2.3.3
- flask-cors 4.0.0
- mysql-connector-python 8.2.0
- python-dotenv 1.0.0
- Werkzeug 2.3.7

## Project Structure

```
FindMyRoof/
├── Backend/
│   ├── app.py                 # Main Flask application
│   ├── config.py              # Configuration settings
│   ├── database.py            # Database connection & queries
│   ├── utils.py               # Utility functions (OTP, email)
│   ├── requirements.txt        # Python dependencies
│   ├── .env.example            # Environment variables template
│   └── .gitignore              # Git ignore rules
├── Frontend/
│   ├── index.html              # Home page
│   ├── properties.html         # Properties listing
│   ├── property-detail.html    # Individual property page
│   ├── post_property.html      # Post new property
│   ├── price_estimator.html    # Price estimation tool
│   ├── emi_calculator.html     # EMI calculation tool
│   ├── contact.html            # Contact page
│   ├── about.html              # About page
│   ├── profile.html            # User profile
│   └── admin.html              # Admin dashboard
├── Photos/                     # Property images
├── README.md                   # This file
└── .gitignore                  # Root level ignore rules
```

## Installation

### Prerequisites
- Python 3.9 or higher
- MySQL Server
- Git

### Backend Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/FindMyRoof.git
   cd FindMyRoof
   ```

2. **Create virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   cd Backend
   pip install -r requirements.txt
   ```

4. **Configure environment variables**
   ```bash
   # Copy the example file
   cp .env.example .env
   
   # Edit .env and add your configuration:
   # - Database credentials
   # - Email settings
   # - Other sensitive data
   ```

5. **Initialize database**
   ```bash
   python database.py
   ```

6. **Run the Flask app**
   ```bash
   python app.py
   ```
   The API will be available at `http://localhost:5000`

### Frontend Setup

1. Open any HTML file in your browser to view the frontend
2. Update API endpoints in HTML files to match your backend URL (default: `http://localhost:5000`)

## Configuration

### Environment Variables (`.env`)

```env
# Database
DB_HOST=localhost
DB_NAME=findmyroof_db
DB_USER=root
DB_PASSWORD=your_password

# Email
EMAIL_ADDRESS=your_email@gmail.com
EMAIL_PASSWORD=your_app_password
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
SMTP_USE_TLS=True

# OTP
OTP_EXPIRES_MINUTES=2

# Flask
FLASK_ENV=development
SECRET_KEY=your_secret_key
```

**Note**: For Gmail, use an [App Password](https://support.google.com/accounts/answer/185833), not your actual password.

## API Endpoints

### Properties
- `GET /api/properties` - Get all properties
- `GET /api/properties?type=apartment` - Filter by property type
- `POST /api/properties` - Create new property

### Authentication
- `POST /api/register` - User registration
- `POST /api/login` - User login
- `POST /api/verify-otp` - Verify OTP

### Admin
- `GET /api/admin/dashboard` - Admin dashboard data
- `DELETE /api/properties/:id` - Delete property

## Deployment

### Deploy to PythonAnywhere

Refer to [DEPLOYMENT.md](DEPLOYMENT.md) for detailed PythonAnywhere deployment instructions.

Quick summary:
1. Create PythonAnywhere account at [pythonanywhere.com](https://www.pythonanywhere.com)
2. Upload code via Git or file upload
3. Set up MySQL database
4. Configure `.env` file
5. Set up WSGI configuration
6. Update API URLs in frontend
7. Reload web app

## Usage

### For Users
1. Visit the home page
2. Browse available properties
3. Register/Login with OTP verification
4. View property details
5. Contact support via contact form
6. Use price estimator and EMI calculator tools

### For Admins
1. Access admin dashboard at `/admin.html`
2. Login with admin credentials
3. Manage properties and users
4. View analytics and reports

## Security Considerations

⚠️ **Important**:
- Never commit `.env` file to version control
- Use environment variables for all sensitive data
- Change default admin passwords immediately
- Use Gmail App Passwords, not your actual password
- Enable HTTPS in production
- Regularly update dependencies
- Validate and sanitize all user inputs

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Troubleshooting

### Database Connection Error
- Check MySQL is running
- Verify credentials in `.env`
- Ensure database exists: `mysql -u root -p < database.sql`

### CORS Errors
- Update CORS origins in `app.py`
- Ensure frontend and backend URLs match configuration

### Email Not Sending
- Verify Gmail App Password in `.env`
- Check SMTP settings
- Enable "Less secure app access" if using Gmail

### Module Import Errors
- Ensure virtual environment is activated
- Run `pip install -r requirements.txt` again
- Check Python path and sys.path configuration

## License

This project is private. All rights reserved.

## Contact

For questions or support, please reach out to the development team:
- Meet Gojariya: meetgojariya214@gmail.com
- Krish Tarpara: tarparakrish0903@gmail.com
- Meet Senjaliya: meetsenjaliya@gmail.com

## Project Status

**Current Version**: 1.0.0  
**Last Updated**: April 2026

---

**Happy coding! 🚀**
