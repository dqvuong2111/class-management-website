# EduManage - Setup Instructions

## Prerequisites
- Python 3.10+
- SQL Server with ODBC Driver 17
- SQL Server Management Studio (SSMS)

---

## Option 1: Fresh Database Setup

### Step 1: Install Dependencies
```powershell
cd "path\to\ClassManagementWebsite"
pip install django mssql-django pyodbc qrcode pillow
```

### Step 2: Create Database in SSMS
```sql
CREATE DATABASE ClassManagementWebsite;
```

### Step 3: Configure Database Connection
Edit `ClassManagementWebsite/settings.py` (lines 79-91):
```python
DATABASES = {
    'default': {
        'ENGINE': 'mssql',
        'NAME': 'ClassManagementWebsite',
        'USER': 'your_username',        # Your SQL Server login
        'PASSWORD': 'your_password',    # Your password
        'HOST': 'localhost',
        'OPTIONS': {
            'driver': 'ODBC Driver 17 for SQL Server',
        },
    }
}
```

### Step 4: Run Migrations
```powershell
python manage.py migrate
```

### Step 5: Create Admin User
```powershell
python manage.py createsuperuser
```

### Step 6: Seed Test Data (Optional)
Open `reset_and_seed_data.sql` in SSMS and execute it.

### Step 7: Run Server
```powershell
python manage.py runserver
```

Access at: http://127.0.0.1:8000

---

## Option 2: Using Existing Database (Drop & Recreate Tables)

### Step 1: Drop All Existing Tables
Run this in SSMS:
```sql
USE ClassManagementWebsite;
GO

-- Disable foreign key constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

-- Drop all tables
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql += 'DROP TABLE [' + TABLE_SCHEMA + '].[' + TABLE_NAME + '];'
FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';
EXEC sp_executesql @sql;

PRINT 'All tables dropped!';
GO
```

### Step 2: Follow Steps 4-7 from Option 1
```powershell
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

Then run `reset_and_seed_data.sql` in SSMS for test data.

---

## Test Accounts (After Running Seed Script)

| Role | Username | Password |
|------|----------|----------|
| Admin | (create with createsuperuser) | (your choice) |
| Teacher | teacher1 | (use Django admin to set) |
| Student | student1 | (use Django admin to set) |

---

## Troubleshooting

### "ODBC Driver 17 not found"
Download from: https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server

### "Login failed"
1. Enable SQL Server Authentication in SSMS
2. Create a SQL login with your credentials
3. Grant db_owner role to the database

### "Migration errors"
Delete all tables and run `python manage.py migrate` again.
