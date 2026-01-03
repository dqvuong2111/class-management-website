# 🎓 EduManage - Class Management System

A comprehensive web-based Class Management System built with Django, featuring modern UI design with Tailwind CSS. This platform enables educational institutions to manage students, teachers, classes, enrollments, assignments, and more.

![Python](https://img.shields.io/badge/Python-3.12+-blue.svg)
![Django](https://img.shields.io/badge/Django-5.1+-green.svg)
![TailwindCSS](https://img.shields.io/badge/TailwindCSS-3.x-38B2AC.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

---

## 📖 Introduction

EduManage is a full-featured educational management platform designed for schools, training centers, and educational institutions. It provides separate dashboards for **Administrators**, **Teachers**, and **Students**, each with role-specific features and modern, responsive UI.

### Key Highlights
- 🎨 Modern, colorful gradient UI design
- 📱 Fully responsive across all devices
- 🔐 Role-based access control (Admin, Teacher, Student)
- 📊 Real-time statistics and analytics
- 💬 Built-in messaging system
- 📋 Assignment and grading management
- 📅 Schedule and attendance tracking

---

## 📁 Project Structure

```
ClassManagementWebsite/
├── accounts/                   # User authentication app
│   ├── templates/accounts/     # Login & Signup templates
│   ├── forms.py               # Authentication forms
│   ├── views.py               # Auth views
│   └── urls.py                # Auth URL routing
│
├── core/                       # Core application
│   ├── models.py              # Database models (Student, Teacher, Class, etc.)
│   ├── views.py               # Public views (home, courses, features)
│   ├── admin.py               # Django admin configuration
│   └── management/commands/   # Custom management commands
│
├── dashboard/                  # Dashboard application
│   ├── templates/dashboard/   # All dashboard templates
│   │   ├── base_dashboard.html           # Admin base
│   │   ├── teacher_base_dashboard.html   # Teacher base
│   │   ├── student_base_dashboard.html   # Student base
│   │   ├── sidebar.html                  # Admin sidebar
│   │   ├── sidebar_teacher.html          # Teacher sidebar
│   │   ├── sidebar_student.html          # Student sidebar
│   │   └── ...                           # Feature-specific templates
│   ├── views.py               # Dashboard views
│   └── urls.py                # Dashboard URL routing
│
├── templates/                  # Global templates
│   ├── base.html              # Base template with navbar/footer
│   └── core/                  # Public page templates
│       ├── home.html          # Homepage
│       ├── class_list.html    # Course listing
│       └── features.html      # Features page
│
├── static/                     # Static assets
│   ├── css/custom.css         # Custom styles & dark mode
│   └── images/                # App images (logo, defaults)
│
├── media/                      # User uploads
│   ├── class_images/          # Course images
│   ├── class_materials/       # Learning materials
│   └── assignment_submissions/ # Student submissions
│
├── ClassManagementWebsite/     # Django project settings
│   ├── settings.py            # Project configuration
│   ├── urls.py                # Root URL routing
│   └── wsgi.py                # WSGI configuration
│
├── manage.py                   # Django management script
├── requirements.txt            # Python dependencies
└── README.md                   # This file
```

---

## ✨ Features

### 🔐 Authentication
- User registration and login
- Role-based access (Admin, Teacher, Student)
- Secure session management

### 👨‍💼 Admin Portal
- **Dashboard** - System overview with statistics
- **Manage Students** - Add, edit, delete students
- **Manage Teachers** - Teacher management
- **Manage Classes** - Create and configure courses
- **Manage Enrollments** - Handle student enrollments
- **Manage Requests** - Approve/reject enrollment requests
- **Enter Grades** - Input student grades
- **Statistics** - View analytics and reports
- **Messages** - Communication hub

### 👨‍🏫 Teacher Portal
- **Dashboard** - Personal teaching overview
- **My Classes** - View assigned classes
- **Assignments** - Create and manage assignments
- **QR Attendance** - Generate QR codes for attendance
- **Schedule** - Calendar view of teaching schedule
- **Statistics** - Class performance analytics
- **Feedback** - View student feedback
- **Messages** - Communicate with students

### 👨‍🎓 Student Portal
- **Dashboard** - Personal learning overview
- **My Courses** - Enrolled courses list
- **Browse Courses** - Explore available classes
- **Schedule** - Weekly class schedule
- **Grades & Achievements** - View academic performance
- **Pending Requests** - Track enrollment status
- **Submit Assignments** - Upload homework
- **Give Feedback** - Rate courses and teachers
- **Messages** - Chat with teachers

### 🎨 UI/UX Features
- Modern gradient design language
- Dark mode support
- Real-time search functionality
- Toast notifications
- Responsive mobile design
- Animated interactions

---

## 🚀 Getting Started

### Prerequisites
- Python 3.12 or higher
- pip (Python package manager)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/ClassManagementWebsite.git
   cd ClassManagementWebsite
   ```

2. **Create a virtual environment**
   ```bash
   python -m venv venv
   ```

3. **Activate the virtual environment**
   
   - **Windows:**
     ```bash
     venv\Scripts\activate
     ```
   - **macOS/Linux:**
     ```bash
     source venv/bin/activate
     ```

4. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

5. **Run database migrations**
   ```bash
   python manage.py migrate
   ```

6. **Create a superuser (Admin account)**
   ```bash
   python manage.py createsuperuser
   ```

7. **(Optional) Load sample data**
   ```bash
   python manage.py seed_data
   ```

8. **Start the development server**
   ```bash
   python manage.py runserver
   ```

9. **Access the application**
   - Homepage: http://127.0.0.1:8000/
   - Admin Panel: http://127.0.0.1:8000/admin/
   - Login: http://127.0.0.1:8000/accounts/login/

---

## 🔑 Default Accounts (after seeding)

| Role    | Username | Password  |
|---------|----------|-----------|
| Admin   | admin    | admin123  |
| Teacher | teacher1 | teacher123|
| Student | student1 | student123|

---

## 🛠️ Technologies Used

- **Backend:** Django 5.1+
- **Frontend:** HTML5, TailwindCSS 3.x, JavaScript
- **Database:** SQLite (development) / PostgreSQL (production)
- **Icons:** Lucide Icons
- **Fonts:** Google Fonts (Outfit)

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

## 📧 Contact

For questions or support, please open an issue in the GitHub repository.

---

Made with ❤️ for Education
