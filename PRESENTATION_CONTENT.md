# EduManage - Class Management System
## Database Lab Presentation

---

## Slide 1: Title & Team

**EduManage - Class Management System**

A website to manage schools and training centers. It helps with class scheduling, student sign-ups, attendance using QR codes, and managing grades.

| Member Name | Student ID | Contribution |
|-------------|------------|--------------|
|             |            | Database Design, Frontend Coding, Testing |
|             |            | Backend Coding, Database Design, Complete Source Code |

---

## Slide 2: Problem Introduction

### Who needs this system?
- Training centers and language schools
- Tutoring services
- Universities and colleges with many classes

### Problems Solved
| Problem | Solution |
|---------|----------|
| Taking attendance by hand | QR code scanning with 4-digit code |
| Student data in many places | One database for all data |
| Paper-based grades | Digital grading with 6 scores |
| Hard to communicate | Built-in messages and notices |
| Messy sign-up process | Request → Approve → Pay steps |

---

## Slide 3: Actors & Use Cases

| Actor | What they do | Main actions |
|-------|--------------|--------------|
| **Admin** | Runs the system | Add/edit users, approve sign-ups, set up classes, see reports |
| **Teacher** | Teaches classes | Make assignments, add files, create QR attendance, give grades |
| **Student** | Takes classes | Look at courses, ask to join, send homework, scan QR, give ratings |

### Main Actions
- **Admin**: Add/Edit/Delete Teachers, Students, Classes; Approve Sign-ups
- **Teacher**: Manage Class Content, Take Attendance, Grade Work
- **Student**: Join Class, Submit Work, Mark Attendance, See Grades

---

## Slide 4: Types of Data We Store

| Data Type | What it is | Where we store it |
|-----------|------------|-------------------|
| **PDF Files** | Homework submissions, learning materials | Material.file, AssignmentSubmission.file |
| **Images** | Class photos, user avatars | Clazz.image |
| **Text (Short)** | Names, emails, titles | full_name, email, class_name |
| **Text (Long)** | Descriptions, comments, messages | description, comment, body |
| **Numbers (Int)** | IDs, scores (1-10) | admin_id, teacher_rate |
| **Numbers (Decimal)** | Prices, grades | price (VND), test scores |
| **Dates** | Birthdays, class dates | dob, start_date, end_date |
| **Time** | Class schedule | start_time, end_time |
| **Yes/No** | Status flags | is_paid, is_read, is_active |
| **Choice** | Limited options | status ('pending', 'approved', 'rejected') |

---

## Slide 5: ERD (Entity Relationship Diagram)

### Relationship Summary

| From | Relationship | To | Type |
|------|--------------|------|------|
| User | has_profile (XOR) | Admin/Teacher/Student | 1:1 |
| ClassType | categorizes | Clazz | 1:N |
| Teacher | teaches | Clazz | 1:N |
| Student | enrolls_in | Enrollment | 1:N |
| Clazz | has | Enrollment | 1:N |
| Enrollment | has | Attendance | 1:N |
| Clazz | has | AttendanceSession | 1:N |
| Clazz | has | Material, Announcement | 1:N |
| Clazz | contains | Assignment | 1:N |
| Assignment | receives | AssignmentSubmission | 1:N |
| Student | submits | AssignmentSubmission | 1:N |
| Student | rates | Feedback | 1:N |
| Clazz | about | Feedback | 1:N |
| User | sends/receives | Message | 1:N |
| Student | has | ContentReadStatus | 1:N |

---

## Slide 6: Relational Schema (15 Tables)

### User Tables (Disjoint Specialization)

**User (Django Built-in)**
```
User(id PK, username, password, email, first_name, last_name, is_staff, is_active, date_joined)
```

**Admin**
```
Admin(admin_id PK, user_id FK→User, full_name, dob, phone_number, email, address, position, created_at, updated_at)
```

**Teacher**
```
Teacher(teacher_id PK, user_id FK→User, full_name, dob, phone_number, email, address, qualification, created_at, updated_at)
```

**Student**
```
Student(student_id PK, user_id FK→User, full_name, dob, phone_number, email, address, created_at, updated_at)
```

### Class Tables

**ClassType**
```
ClassType(type_id PK, code UNIQUE, description, created_at, updated_at)
```

**Clazz**
```
Clazz(class_id PK, class_name, class_type_id FK→ClassType, teacher_id FK→Teacher, 
      start_date, end_date, price, room, image, day_of_week, start_time, end_time, created_at, updated_at)
```

### Enrollment & Attendance Tables

**Enrollment**
```
Enrollment(enrollment_id PK, student_id FK→Student, clazz_id FK→Clazz, enrollment_date, status, is_paid, 
           minitest1, minitest2, minitest3, minitest4, midterm, final_test, created_at, updated_at)
UNIQUE(student_id, clazz_id)
```

**Attendance**
```
Attendance(attendance_id PK, enrollment_id FK→Enrollment, date, status, created_at, updated_at)
```

**AttendanceSession**
```
AttendanceSession(session_id PK, clazz_id FK→Clazz, date, token UNIQUE, passcode, is_active, created_at)
```

### Content Tables

**Material**
```
Material(id PK, title, file, clazz_id FK→Clazz, uploaded_at)
```

**Announcement**
```
Announcement(id PK, title, content, clazz_id FK→Clazz, posted_at)
```

**Assignment**
```
Assignment(id PK, title, description, due_date, clazz_id FK→Clazz, created_at)
```

**AssignmentSubmission**
```
AssignmentSubmission(id PK, assignment_id FK→Assignment, student_id FK→Student, 
                     submission_file, submitted_at, grade, feedback)
UNIQUE(assignment_id, student_id)
```

### Interaction Tables

**Feedback**
```
Feedback(feedback_id PK, student_id FK→Student, clazz_id FK→Clazz, 
         teacher_rate, class_rate, comment, created_at, updated_at)
```

**Message**
```
Message(id PK, sender_id FK→User, recipient_id FK→User, subject, body, is_read, created_at)
```

**ContentReadStatus**
```
ContentReadStatus(id PK, student_id FK→Student, content_type, content_id, is_read, read_at)
UNIQUE(student_id, content_type, content_id)
```

---

## Slide 7: Data Types & Rules

| Type | SQL Type | Examples |
|------|----------|----------|
| ID (Primary Key) | INT IDENTITY(1,1) | admin_id, teacher_id |
| Link (Foreign Key) | INT with FK | user_id, clazz_id |
| Short Text | NVARCHAR(n) | full_name, email |
| Long Text | NVARCHAR(MAX) | description, comment |
| Date/Time | DATE, TIME, DATETIME | dob, start_date |
| Money | DECIMAL(10,2) | price |
| Score | FLOAT, DECIMAL(3,2) | test1, teacher_score |
| Yes/No | BIT | is_paid, is_read |

### Constraints

| Table | Constraint | Rule |
|-------|------------|------|
| core_enrollment | Status | Only 'pending', 'approved', 'rejected' |
| core_attendance | Status | Only 'Present', 'Absent', 'Excused' |
| core_feedback | Rating | Teacher & class ratings must be 1-10 |
| core_enrollment | Grades | All 6 test scores must be 0-10 |
| core_clazz | Price | Must be >= 0 |
| core_clazz | Dates | End date >= start date |
| core_clazz | Times | End time > start time |
| core_attendancesession | Passcode | Must be exactly 4 digits |

---

## Slide 8: Project Results

### What We Built
- ✅ 3 Portals (Admin, Teacher, Student)
- ✅ 15 Database Tables with rules
- ✅ Follows 3NF (no repeated data)
- ✅ QR Attendance with 4-digit code
- ✅ Homework: create, submit, grade
- ✅ Message system
- ✅ Student rating system

### Tools Used
| Part | Tool |
|------|------|
| Backend | Django 5.2 (Python) |
| Database | MS SQL Server |
| Frontend | HTML5, CSS, JavaScript |
| Database Link | Django ORM + mssql-django |

### Demo
Live show:
1. Admin makes a class and approves sign-ups
2. Teacher makes QR for attendance
3. Student scans QR to mark attendance

---

*End of Presentation*
