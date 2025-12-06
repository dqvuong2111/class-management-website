# Class Management Website

This is a Django-based web application for managing classes, students, and enrollments.

## Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd ClassManagementWebsite
   ```

2. **Create a virtual environment:**
   ```bash
   python -m venv venv
   ```

3. **Activate the virtual environment:**
   - On Windows:
     ```bash
     .\venv\Scripts\activate
     ```
   - On macOS/Linux:
     ```bash
     source venv/bin/activate
     ```

4. **Install the dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

5. **Apply migrations:**
   ```bash
   python manage.py migrate
   ```

6. **Run the development server:**
   ```bash
   python manage.py runserver
   ```

The application will be available at `http://127.0.0.1:8000/`.
