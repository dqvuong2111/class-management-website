# EduManage - Class Management System
## Database Lab Presentation

---

## Slide 1: Title & Team

**EduManage - Class Management System**

A web-based platform for managing educational institutions with class scheduling, student enrollment, QR attendance tracking, and grade management.

| Member Name | Student ID | Contribution |
|-------------|------------|--------------|
|             |            |              |
|             |            |              |
|             |            |              |

---

## Slide 2: Problem Introduction

### Who needs this system?
- Educational training centers and language schools
- Tutoring services and coaching facilities
- Universities and colleges managing multiple classes

### Problems Solved
| Problem | Solution |
|---------|----------|
| Manual attendance tracking | QR code scanning with passcode verification |
| Scattered student records | Centralized database with role-based access |
| Paper-based grade management | Digital grading system with 6 components |
| Poor communication | Built-in messaging and announcements |
| Enrollment chaos | Request → Approve → Payment workflow |

---

## Slide 3: Actors & Use Cases

| Actor | Description | Key Use Cases |
|-------|-------------|---------------|
| **Admin** | System administrator | Manage users, approve enrollments, configure classes, view statistics |
| **Teacher** | Assigned instructor | Create assignments, upload materials, generate QR attendance, enter grades |
| **Student** | Class participant | Browse courses, request enrollment, submit assignments, scan QR attendance, give feedback |

### Use Case Diagram (Main Flows)
- **Admin**: CRUD Teachers, CRUD Students, CRUD Classes, Approve Enrollments
- **Teacher**: Manage Class Content, Take Attendance, Grade Assignments
- **Student**: Enroll in Class, Submit Assignment, Mark Attendance, View Grades

---

## Slide 4: Data Types Managed

| Data Category | Tables | Description |
|---------------|--------|-------------|
| **Users** | auth_user, Admin, Teacher, Student | Authentication and role-specific profiles |
| **Classes** | ClassType, Clazz | Course categories and class instances |
| **Enrollment** | Enrollment | Student-class relationships with grades |
| **Attendance** | Attendance, AttendanceSession | Daily records and QR session management |
| **Content** | Material, Announcement, Assignment | Learning resources and class updates |
| **Interaction** | Feedback, Message, AssignmentSubmission | User communication and submissions |

---

## Slide 5: Entity-Relationship Diagram

### Key Relationships

```
User (1) ──── (1) Admin/Teacher/Student    [One user has one role profile]
Teacher (1) ──── (N) Clazz                 [One teacher teaches many classes]
Student (1) ──── (N) Enrollment            [One student enrolls in many classes]
Clazz (1) ──── (N) Enrollment              [One class has many enrollments]
Enrollment (1) ──── (N) Attendance         [One enrollment has many attendance records]
Clazz (1) ──── (N) Assignment              [One class has many assignments]
Assignment (1) ──── (N) AssignmentSubmission [One assignment has many submissions]
Student (1) ──── (N) Feedback              [One student gives feedback to many classes]
```

### ERD Visual
- 15 entities with proper 1:1, 1:N relationships
- Normalized to 3NF (Third Normal Form)
- Separate tables for each role (Admin, Teacher, Student)

---

## Slide 6: Relational Schema (15 Tables)

### Role Tables (Separated for 3NF)

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

### Core Tables

**ClassType**
```
ClassType(type_id PK, code UNIQUE, description, created_at, updated_at)
```

**Clazz**
```
Clazz(class_id PK, class_name, class_type_id FK→ClassType, teacher_id FK→Teacher, staff_id FK→Admin, start_date, end_date, price, room, image, day_of_week, start_time, end_time, created_at, updated_at)
```

**Enrollment**
```
Enrollment(enrollment_id PK, student_id FK→Student, clazz_id FK→Clazz, enrollment_date, status, is_paid, minitest1, minitest2, minitest3, minitest4, midterm, final_test, created_at, updated_at)
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
AssignmentSubmission(id PK, assignment_id FK→Assignment, student_id FK→Student, submission_file, submitted_at, grade, feedback)
UNIQUE(assignment_id, student_id)
```

### Interaction Tables

**Feedback**
```
Feedback(feedback_id PK, student_id FK→Student, clazz_id FK→Clazz, teacher_rate, class_rate, comment, created_at, updated_at)
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

## Slide 7: Data Types & Constraints

| Field Type | SQL Type | Example Fields |
|------------|----------|----------------|
| Primary Key | INT IDENTITY(1,1) | admin_id, teacher_id, student_id |
| Foreign Key | INT with FK constraint | user_id, teacher_id, clazz_id |
| String | NVARCHAR(n) | full_name, email, class_name |
| Text | NVARCHAR(MAX) | description, comment, body |
| Date/Time | DATE, TIME, DATETIME | dob, start_date, created_at |
| Decimal | DECIMAL(10,2), DECIMAL(3,2) | price, teacher_rate |
| Float | FLOAT | minitest1, grade |
| Boolean | BIT | is_paid, is_read, is_active |

### Key Constraints

| Constraint | Table | Description |
|------------|-------|-------------|
| UNIQUE | Enrollment(student_id, clazz_id) | Prevent duplicate enrollments |
| CHECK | Enrollment.status | IN ('pending', 'approved', 'rejected') |
| CHECK | Attendance.status | IN ('Present', 'Absent', 'Late') |
| NOT NULL | Required fields | full_name, email, class_name, etc. |

---

## Slide 8: Project Results

### Features Implemented
- ✅ 3 Role-Based Portals (Admin, Teacher, Student)
- ✅ 15 Database Tables with proper constraints
- ✅ Normalized to 3NF (Third Normal Form)
- ✅ QR Attendance with 4-digit passcode verification
- ✅ Assignment creation, submission, and grading
- ✅ Internal messaging system
- ✅ Student feedback and rating system

### Technology Stack
| Component | Technology |
|-----------|------------|
| Backend | Django 5.2 (Python) |
| Database | MS SQL Server |
| Frontend | HTML5, CSS, JavaScript |
| ORM | Django ORM with mssql-django |

### Demo
Live demonstration of:
1. Admin creating a class and approving enrollments
2. Teacher generating QR attendance
3. Student scanning QR and marking attendance

---

*End of Presentation*
