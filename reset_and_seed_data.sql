-- ============================================
-- T-SQL Script: Reset and Seed Large Sample Data
-- Database: ClassManagementWebsite
-- Description: Deletes all data and creates large sample dataset
-- Author: Auto-generated
-- Date: 2026-01-03
-- ============================================

USE ClassManagementWebsite;
GO

-- ============================================
-- PART 1: DELETE ALL DATA (in correct order due to FK constraints)
-- ============================================

PRINT 'Starting data cleanup...';

-- Disable all foreign key constraints temporarily
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

-- Delete from child tables first (in dependency order)
DELETE FROM core_studentassignmentreadstatus;
DELETE FROM core_studentannouncementreadstatus;
DELETE FROM core_assignmentsubmission;
DELETE FROM core_assignment;
DELETE FROM core_announcement;
DELETE FROM core_material;
DELETE FROM core_attendancesession;
DELETE FROM core_message;
DELETE FROM core_feedback;
DELETE FROM core_attendance;
DELETE FROM core_schedule;
DELETE FROM core_enrollment;
DELETE FROM core_clazz;
DELETE FROM core_classtype;
DELETE FROM core_staff;
DELETE FROM core_student;
DELETE FROM core_teacher;

-- Delete Django auth users (except superuser if needed)
DELETE FROM auth_user WHERE is_superuser = 0;

-- Re-enable all foreign key constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL';

-- Reset identity columns
DBCC CHECKIDENT ('core_teacher', RESEED, 0);
DBCC CHECKIDENT ('core_student', RESEED, 0);
DBCC CHECKIDENT ('core_staff', RESEED, 0);
DBCC CHECKIDENT ('core_classtype', RESEED, 0);
DBCC CHECKIDENT ('core_clazz', RESEED, 0);
DBCC CHECKIDENT ('core_enrollment', RESEED, 0);
DBCC CHECKIDENT ('core_schedule', RESEED, 0);
DBCC CHECKIDENT ('core_attendance', RESEED, 0);
DBCC CHECKIDENT ('core_feedback', RESEED, 0);
DBCC CHECKIDENT ('core_attendancesession', RESEED, 0);
DBCC CHECKIDENT ('core_material', RESEED, 0);
DBCC CHECKIDENT ('core_announcement', RESEED, 0);
DBCC CHECKIDENT ('core_assignment', RESEED, 0);
DBCC CHECKIDENT ('core_assignmentsubmission', RESEED, 0);
DBCC CHECKIDENT ('core_studentannouncementreadstatus', RESEED, 0);
DBCC CHECKIDENT ('core_studentassignmentreadstatus', RESEED, 0);

PRINT 'Data cleanup complete!';
GO

-- ============================================
-- PART 2: INSERT LARGE SAMPLE DATA
-- ============================================

PRINT 'Starting data insertion...';

-- ============================================
-- 2.1 Create Class Types (6 types)
-- ============================================
INSERT INTO core_classtype (code, description, created_at, updated_at) VALUES
('MATH', N'Mathematics courses including algebra, calculus, and geometry', GETDATE(), GETDATE()),
('ENG', N'English language courses including grammar, writing, and literature', GETDATE(), GETDATE()),
('SCI', N'Science courses including physics, chemistry, and biology', GETDATE(), GETDATE()),
('CS', N'Computer Science courses including programming and data structures', GETDATE(), GETDATE()),
('IELTS', N'IELTS preparation courses for international English testing', GETDATE(), GETDATE()),
('TOEIC', N'TOEIC preparation courses for business English proficiency', GETDATE(), GETDATE());

PRINT 'Inserted 6 class types';

-- ============================================
-- 2.2 Create Staff (10 staff members)
-- ============================================
INSERT INTO core_staff (full_name, dob, phone_number, email, address, position, created_at, updated_at) VALUES
(N'Nguyen Van Admin', '1985-03-15', '0901234567', 'admin1@school.edu.vn', N'123 Nguyen Hue, District 1, HCMC', N'Academic Director', GETDATE(), GETDATE()),
(N'Tran Thi Secretary', '1990-07-22', '0902345678', 'secretary1@school.edu.vn', N'456 Le Loi, District 1, HCMC', N'Academic Secretary', GETDATE(), GETDATE()),
(N'Le Van Manager', '1982-11-08', '0903456789', 'manager1@school.edu.vn', N'789 Dong Khoi, District 1, HCMC', N'Enrollment Manager', GETDATE(), GETDATE()),
(N'Pham Thi Coordinator', '1988-05-14', '0904567890', 'coordinator1@school.edu.vn', N'321 Hai Ba Trung, District 3, HCMC', N'Course Coordinator', GETDATE(), GETDATE()),
(N'Hoang Van Support', '1995-09-30', '0905678901', 'support1@school.edu.vn', N'654 Vo Van Tan, District 3, HCMC', N'Student Support', GETDATE(), GETDATE()),
(N'Nguyen Thi Finance', '1987-02-18', '0906789012', 'finance1@school.edu.vn', N'987 Nam Ky Khoi Nghia, District 3, HCMC', N'Financial Officer', GETDATE(), GETDATE()),
(N'Tran Van IT', '1992-06-25', '0907890123', 'it1@school.edu.vn', N'147 Nguyen Dinh Chieu, District 3, HCMC', N'IT Administrator', GETDATE(), GETDATE()),
(N'Le Thi HR', '1989-12-03', '0908901234', 'hr1@school.edu.vn', N'258 Pasteur, District 1, HCMC', N'HR Manager', GETDATE(), GETDATE()),
(N'Pham Van Facility', '1980-08-17', '0909012345', 'facility1@school.edu.vn', N'369 Cach Mang Thang 8, District 10, HCMC', N'Facility Manager', GETDATE(), GETDATE()),
(N'Hoang Thi Reception', '1998-04-21', '0910123456', 'reception1@school.edu.vn', N'741 Ly Tu Trong, District 1, HCMC', N'Receptionist', GETDATE(), GETDATE());

PRINT 'Inserted 10 staff members';

-- ============================================
-- 2.3 Create Django Users for Teachers (20 teachers)
-- ============================================
-- Note: password is 'teacher123' hashed with Django's PBKDF2
DECLARE @teacher_password NVARCHAR(MAX) = 'pbkdf2_sha256$870000$salt$hashedpassword'; -- Placeholder, Django will handle auth

INSERT INTO auth_user (username, password, first_name, last_name, email, is_staff, is_active, is_superuser, date_joined) VALUES
('teacher1', @teacher_password, N'Nguyen', N'Van Toan', 'teacher1@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher2', @teacher_password, N'Tran', N'Thi Lan', 'teacher2@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher3', @teacher_password, N'Le', N'Van Hoang', 'teacher3@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher4', @teacher_password, N'Pham', N'Thi Mai', 'teacher4@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher5', @teacher_password, N'Hoang', N'Van Duc', 'teacher5@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher6', @teacher_password, N'Nguyen', N'Thi Hoa', 'teacher6@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher7', @teacher_password, N'Tran', N'Van Minh', 'teacher7@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher8', @teacher_password, N'Le', N'Thi Thu', 'teacher8@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher9', @teacher_password, N'Pham', N'Van Khanh', 'teacher9@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher10', @teacher_password, N'Hoang', N'Thi Linh', 'teacher10@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher11', @teacher_password, N'Vo', N'Van Thanh', 'teacher11@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher12', @teacher_password, N'Dang', N'Thi Ngoc', 'teacher12@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher13', @teacher_password, N'Bui', N'Van Long', 'teacher13@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher14', @teacher_password, N'Do', N'Thi Huong', 'teacher14@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher15', @teacher_password, N'Ngo', N'Van Tuan', 'teacher15@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher16', @teacher_password, N'Duong', N'Thi Kim', 'teacher16@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher17', @teacher_password, N'Ly', N'Van Phuc', 'teacher17@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher18', @teacher_password, N'Truong', N'Thi Ha', 'teacher18@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher19', @teacher_password, N'Dinh', N'Van Nam', 'teacher19@school.edu.vn', 0, 1, 0, GETDATE()),
('teacher20', @teacher_password, N'Vu', N'Thi Anh', 'teacher20@school.edu.vn', 0, 1, 0, GETDATE());

-- ============================================
-- 2.4 Create Teachers (20 teachers)
-- ============================================
INSERT INTO core_teacher (user_id, full_name, dob, phone_number, email, address, qualification, created_at, updated_at)
SELECT 
    u.id,
    CONCAT(u.first_name, ' ', u.last_name),
    DATEADD(YEAR, -30 - (ROW_NUMBER() OVER (ORDER BY u.id) % 15), GETDATE()),
    CONCAT('09', RIGHT('00000000' + CAST(ABS(CHECKSUM(NEWID())) % 100000000 AS VARCHAR), 8)),
    u.email,
    CONCAT(N'Số ', ROW_NUMBER() OVER (ORDER BY u.id), N', Đường ', 
           CASE (ROW_NUMBER() OVER (ORDER BY u.id) % 5)
               WHEN 0 THEN N'Nguyễn Huệ'
               WHEN 1 THEN N'Lê Lợi'
               WHEN 2 THEN N'Đồng Khởi'
               WHEN 3 THEN N'Hai Bà Trưng'
               ELSE N'Võ Văn Tần'
           END, N', HCMC'),
    CASE (ROW_NUMBER() OVER (ORDER BY u.id) % 4)
        WHEN 0 THEN 'Ph.D in Mathematics'
        WHEN 1 THEN 'Master in English Literature'
        WHEN 2 THEN 'Ph.D in Computer Science'
        ELSE 'Master in Education'
    END,
    GETDATE(),
    GETDATE()
FROM auth_user u
WHERE u.username LIKE 'teacher%';

PRINT 'Inserted 20 teachers';

-- ============================================
-- 2.5 Create Django Users for Students (150 students)
-- ============================================
DECLARE @student_password NVARCHAR(MAX) = 'pbkdf2_sha256$870000$salt$hashedpassword';
DECLARE @i INT = 1;

WHILE @i <= 150
BEGIN
    INSERT INTO auth_user (username, password, first_name, last_name, email, is_staff, is_active, is_superuser, date_joined)
    VALUES (
        CONCAT('student', @i),
        @student_password,
        CASE (@i % 10)
            WHEN 0 THEN N'Nguyen'
            WHEN 1 THEN N'Tran'
            WHEN 2 THEN N'Le'
            WHEN 3 THEN N'Pham'
            WHEN 4 THEN N'Hoang'
            WHEN 5 THEN N'Vo'
            WHEN 6 THEN N'Dang'
            WHEN 7 THEN N'Bui'
            WHEN 8 THEN N'Do'
            ELSE N'Ngo'
        END,
        CASE (@i % 15)
            WHEN 0 THEN N'Van An'
            WHEN 1 THEN N'Thi Binh'
            WHEN 2 THEN N'Van Cuong'
            WHEN 3 THEN N'Thi Dung'
            WHEN 4 THEN N'Van Em'
            WHEN 5 THEN N'Thi Phuong'
            WHEN 6 THEN N'Van Gia'
            WHEN 7 THEN N'Thi Hang'
            WHEN 8 THEN N'Van Ich'
            WHEN 9 THEN N'Thi Kim'
            WHEN 10 THEN N'Van Lam'
            WHEN 11 THEN N'Thi My'
            WHEN 12 THEN N'Van Nam'
            WHEN 13 THEN N'Thi Oanh'
            ELSE N'Van Phong'
        END,
        CONCAT('student', @i, '@student.edu.vn'),
        0, 1, 0, GETDATE()
    );
    SET @i = @i + 1;
END;

-- ============================================
-- 2.6 Create Students (150 students)
-- ============================================
INSERT INTO core_student (user_id, full_name, dob, phone_number, email, address, created_at, updated_at)
SELECT 
    u.id,
    CONCAT(u.first_name, ' ', u.last_name),
    DATEADD(YEAR, -18 - (ROW_NUMBER() OVER (ORDER BY u.id) % 10), GETDATE()),
    CONCAT('09', RIGHT('00000000' + CAST(ABS(CHECKSUM(NEWID())) % 100000000 AS VARCHAR), 8)),
    u.email,
    CONCAT(N'Số ', ROW_NUMBER() OVER (ORDER BY u.id), N', Phường ', 
           (ROW_NUMBER() OVER (ORDER BY u.id) % 20) + 1, N', Quận ', 
           (ROW_NUMBER() OVER (ORDER BY u.id) % 12) + 1, N', HCMC'),
    GETDATE(),
    GETDATE()
FROM auth_user u
WHERE u.username LIKE 'student%';

PRINT 'Inserted 150 students';

-- ============================================
-- 2.7 Create Classes (30 classes)
-- ============================================
DECLARE @class_id INT = 1;
DECLARE @type_id INT;
DECLARE @teacher_id INT;
DECLARE @staff_id INT;

WHILE @class_id <= 30
BEGIN
    SET @type_id = ((@class_id - 1) % 6) + 1;
    SET @teacher_id = ((@class_id - 1) % 20) + 1;
    SET @staff_id = ((@class_id - 1) % 10) + 1;
    
    INSERT INTO core_clazz (class_name, class_type_id, teacher_id, staff_id, start_date, end_date, price, room, image, created_at, updated_at)
    VALUES (
        CONCAT(
            CASE @type_id
                WHEN 1 THEN 'MATH'
                WHEN 2 THEN 'ENG'
                WHEN 3 THEN 'SCI'
                WHEN 4 THEN 'CS'
                WHEN 5 THEN 'IELTS'
                ELSE 'TOEIC'
            END,
            '-',
            CASE WHEN @class_id <= 10 THEN 'BEG' WHEN @class_id <= 20 THEN 'INT' ELSE 'ADV' END,
            '-',
            RIGHT('00' + CAST(@class_id AS VARCHAR), 2)
        ),
        @type_id,
        @teacher_id,
        @staff_id,
        DATEADD(DAY, -30 + (@class_id * 3), GETDATE()),
        DATEADD(DAY, 60 + (@class_id * 3), GETDATE()),
        CASE @type_id
            WHEN 1 THEN 2500000.00
            WHEN 2 THEN 2800000.00
            WHEN 3 THEN 3000000.00
            WHEN 4 THEN 3500000.00
            WHEN 5 THEN 5000000.00
            ELSE 4500000.00
        END,
        CONCAT('Room ', ((@class_id - 1) % 10) + 101),
        'class_images/default_class.png',
        GETDATE(),
        GETDATE()
    );
    
    SET @class_id = @class_id + 1;
END;

PRINT 'Inserted 30 classes';

-- ============================================
-- 2.8 Create Schedules (30 schedules, one per class)
-- ============================================
INSERT INTO core_schedule (clazz_id, day_of_week, start_time, end_time, created_at, updated_at)
SELECT 
    c.class_id,
    CASE (c.class_id % 5)
        WHEN 0 THEN 'Monday, Wednesday, Friday'
        WHEN 1 THEN 'Tuesday, Thursday, Saturday'
        WHEN 2 THEN 'Monday, Wednesday'
        WHEN 3 THEN 'Tuesday, Thursday'
        ELSE 'Saturday, Sunday'
    END,
    CASE (c.class_id % 3)
        WHEN 0 THEN '08:00:00'
        WHEN 1 THEN '13:30:00'
        ELSE '18:00:00'
    END,
    CASE (c.class_id % 3)
        WHEN 0 THEN '10:00:00'
        WHEN 1 THEN '15:30:00'
        ELSE '20:00:00'
    END,
    GETDATE(),
    GETDATE()
FROM core_clazz c;

PRINT 'Inserted 30 schedules';

-- ============================================
-- 2.9 Create Enrollments (~500 enrollments)
-- Each student enrolls in 3-4 classes
-- ============================================
INSERT INTO core_enrollment (student_id, clazz_id, enrollment_date, status, is_paid, 
    minitest1, minitest2, minitest3, minitest4, midterm, final_test, created_at, updated_at)
SELECT 
    s.student_id,
    c.class_id,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 30, GETDATE()),
    CASE (ABS(CHECKSUM(NEWID())) % 10)
        WHEN 0 THEN 'pending'
        WHEN 1 THEN 'rejected'
        ELSE 'approved'
    END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 10 > 2 THEN 1 ELSE 0 END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN NULL ELSE CAST(5 + (ABS(CHECKSUM(NEWID())) % 50) / 10.0 AS FLOAT) END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN NULL ELSE CAST(5 + (ABS(CHECKSUM(NEWID())) % 50) / 10.0 AS FLOAT) END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN NULL ELSE CAST(5 + (ABS(CHECKSUM(NEWID())) % 50) / 10.0 AS FLOAT) END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN NULL ELSE CAST(5 + (ABS(CHECKSUM(NEWID())) % 50) / 10.0 AS FLOAT) END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 4 = 0 THEN NULL ELSE CAST(5 + (ABS(CHECKSUM(NEWID())) % 50) / 10.0 AS FLOAT) END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 5 = 0 THEN NULL ELSE CAST(5 + (ABS(CHECKSUM(NEWID())) % 50) / 10.0 AS FLOAT) END,
    GETDATE(),
    GETDATE()
FROM core_student s
CROSS JOIN core_clazz c
WHERE (s.student_id + c.class_id) % 9 < 3; -- Creates ~500 enrollments

PRINT 'Inserted enrollments (approximately 500)';

-- ============================================
-- 2.10 Create Attendance Records (~2500 records)
-- ============================================
INSERT INTO core_attendance (enrollment_id, date, status, created_at, updated_at)
SELECT 
    e.enrollment_id,
    DATEADD(DAY, -n.num, GETDATE()),
    CASE (ABS(CHECKSUM(NEWID())) % 20)
        WHEN 0 THEN 'Absent'
        WHEN 1 THEN 'Excused'
        ELSE 'Present'
    END,
    GETDATE(),
    GETDATE()
FROM core_enrollment e
CROSS JOIN (
    SELECT 0 AS num UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
) n
WHERE e.status = 'approved';

PRINT 'Inserted attendance records';

-- ============================================
-- 2.11 Create Feedback (~200 feedback entries)
-- ============================================
INSERT INTO core_feedback (student_id, teacher_id, clazz_id, teacher_rate, class_rate, comment, created_at, updated_at)
SELECT TOP 200
    e.student_id,
    c.teacher_id,
    e.clazz_id,
    CAST(6 + (ABS(CHECKSUM(NEWID())) % 40) / 10.0 AS DECIMAL(3,2)),
    CAST(6 + (ABS(CHECKSUM(NEWID())) % 40) / 10.0 AS DECIMAL(3,2)),
    CASE (ABS(CHECKSUM(NEWID())) % 5)
        WHEN 0 THEN N'Excellent teaching! Very clear explanations and patient with students.'
        WHEN 1 THEN N'Good class structure and helpful materials. Would recommend.'
        WHEN 2 THEN N'The teacher is knowledgeable and engaging. Enjoyed the course.'
        WHEN 3 THEN N'Well-organized course with practical examples. Very useful.'
        ELSE N'Great learning experience. The teacher made complex topics easy to understand.'
    END,
    GETDATE(),
    GETDATE()
FROM core_enrollment e
JOIN core_clazz c ON e.clazz_id = c.class_id
WHERE e.status = 'approved' AND c.teacher_id IS NOT NULL
ORDER BY NEWID();

PRINT 'Inserted 200 feedback entries';

-- ============================================
-- 2.12 Create Announcements (~60 announcements)
-- ============================================
INSERT INTO core_announcement (title, content, clazz_id, posted_at)
SELECT 
    CONCAT(
        CASE (c.class_id % 6)
            WHEN 0 THEN N'Important Update: '
            WHEN 1 THEN N'Reminder: '
            WHEN 2 THEN N'Notice: '
            WHEN 3 THEN N'Schedule Change: '
            WHEN 4 THEN N'Exam Information: '
            ELSE N'Class News: '
        END,
        c.class_name
    ),
    CASE (c.class_id % 5)
        WHEN 0 THEN N'Please note that there will be a quiz next session. Make sure to review chapters 1-3.'
        WHEN 1 THEN N'The classroom has been changed to Room 205 for this week only due to maintenance.'
        WHEN 2 THEN N'Congratulations to all students who achieved excellent scores in the midterm exam!'
        WHEN 3 THEN N'Additional study materials have been uploaded. Please check the course materials section.'
        ELSE N'Office hours have been extended this week. Feel free to come for extra help.'
    END,
    c.class_id,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 30, GETDATE())
FROM core_clazz c
CROSS JOIN (SELECT 1 AS n UNION SELECT 2) AS mult;

PRINT 'Inserted 60 announcements';

-- ============================================
-- 2.13 Create Assignments (~90 assignments)
-- ============================================
INSERT INTO core_assignment (title, description, due_date, clazz_id, created_at)
SELECT 
    CONCAT(
        CASE ((c.class_id + n.num) % 5)
            WHEN 0 THEN N'Homework '
            WHEN 1 THEN N'Project '
            WHEN 2 THEN N'Essay '
            WHEN 3 THEN N'Quiz '
            ELSE N'Lab Exercise '
        END,
        n.num, ' - ', c.class_name
    ),
    CASE ((c.class_id + n.num) % 5)
        WHEN 0 THEN N'Complete exercises 1-10 from chapter ' + CAST(n.num AS NVARCHAR) + N'. Show all your work for full credit.'
        WHEN 1 THEN N'Work in groups of 3-4 to complete the project. Submit a report and presentation slides.'
        WHEN 2 THEN N'Write a 500-word essay on the topic covered in class. Include at least 3 references.'
        WHEN 3 THEN N'Online quiz covering the material from weeks ' + CAST(n.num AS NVARCHAR) + N'-' + CAST(n.num + 1 AS NVARCHAR) + N'. You have 30 minutes.'
        ELSE N'Complete the lab exercises and submit your code. Include comments explaining your solution.'
    END,
    DATEADD(DAY, 7 + (c.class_id + n.num * 5), GETDATE()),
    c.class_id,
    GETDATE()
FROM core_clazz c
CROSS JOIN (SELECT 1 AS num UNION SELECT 2 UNION SELECT 3) n;

PRINT 'Inserted 90 assignments';

-- ============================================
-- 2.14 Create Assignment Submissions (~300 submissions)
-- ============================================
INSERT INTO core_assignmentsubmission (assignment_id, student_id, submission_file, submitted_at, grade, feedback)
SELECT TOP 300
    a.id,
    e.student_id,
    CONCAT('assignment_submissions/submission_', a.id, '_', e.student_id, '.pdf'),
    DATEADD(HOUR, -ABS(CHECKSUM(NEWID())) % 72, a.due_date),
    CASE WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN NULL 
         ELSE CAST(6 + (ABS(CHECKSUM(NEWID())) % 40) / 10.0 AS FLOAT) END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN '' 
         ELSE CASE (ABS(CHECKSUM(NEWID())) % 4)
            WHEN 0 THEN N'Good work! Keep it up.'
            WHEN 1 THEN N'Excellent effort. Well structured.'
            WHEN 2 THEN N'Some improvements needed in section 2.'
            ELSE N'Nice attempt. Review the feedback for improvements.'
         END
    END
FROM core_assignment a
JOIN core_clazz c ON a.clazz_id = c.class_id
JOIN core_enrollment e ON e.clazz_id = c.class_id AND e.status = 'approved'
ORDER BY NEWID();

PRINT 'Inserted assignment submissions';

-- ============================================
-- 2.15 Create Materials (~60 materials)
-- ============================================
INSERT INTO core_material (title, [file], clazz_id, uploaded_at)
SELECT 
    CONCAT(
        CASE ((c.class_id + n.num) % 4)
            WHEN 0 THEN N'Lecture Notes - Week '
            WHEN 1 THEN N'Practice Problems - Set '
            WHEN 2 THEN N'Study Guide - Chapter '
            ELSE N'Reference Material - Part '
        END,
        n.num
    ),
    CONCAT('class_materials/', c.class_name, '_material_', n.num, '.pdf'),
    c.class_id,
    DATEADD(DAY, -n.num * 7, GETDATE())
FROM core_clazz c
CROSS JOIN (SELECT 1 AS num UNION SELECT 2) n;

PRINT 'Inserted 60 materials';

-- ============================================
-- 2.16 Create Attendance Sessions (~30 sessions)
-- ============================================
INSERT INTO core_attendancesession (clazz_id, date, token, is_active, created_at)
SELECT 
    c.class_id,
    CAST(GETDATE() AS DATE),
    LEFT(REPLACE(CONCAT(NEWID(), NEWID()), '-', ''), 64),
    CASE WHEN c.class_id % 3 = 0 THEN 1 ELSE 0 END,
    GETDATE()
FROM core_clazz c;

PRINT 'Inserted 30 attendance sessions';

-- ============================================
-- 2.17 Create Read Statuses for Announcements
-- ============================================
INSERT INTO core_studentannouncementreadstatus (student_id, announcement_id, is_read, read_at)
SELECT TOP 500
    e.student_id,
    a.id,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN 0 ELSE 1 END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN NULL ELSE DATEADD(HOUR, -ABS(CHECKSUM(NEWID())) % 168, GETDATE()) END
FROM core_enrollment e
JOIN core_announcement a ON a.clazz_id = e.clazz_id
WHERE e.status = 'approved'
ORDER BY NEWID();

PRINT 'Inserted announcement read statuses';

-- ============================================
-- 2.18 Create Read Statuses for Assignments
-- ============================================
INSERT INTO core_studentassignmentreadstatus (student_id, assignment_id, is_read, read_at)
SELECT TOP 600
    e.student_id,
    a.id,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 4 = 0 THEN 0 ELSE 1 END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 4 = 0 THEN NULL ELSE DATEADD(HOUR, -ABS(CHECKSUM(NEWID())) % 168, GETDATE()) END
FROM core_enrollment e
JOIN core_assignment a ON a.clazz_id = e.clazz_id
WHERE e.status = 'approved'
ORDER BY NEWID();

PRINT 'Inserted assignment read statuses';

-- ============================================
-- SUMMARY
-- ============================================
PRINT '============================================';
PRINT 'DATA SEEDING COMPLETE!';
PRINT '============================================';
PRINT '';

SELECT 'Class Types' AS [Table], COUNT(*) AS [Count] FROM core_classtype
UNION ALL SELECT 'Staff', COUNT(*) FROM core_staff
UNION ALL SELECT 'Teachers', COUNT(*) FROM core_teacher
UNION ALL SELECT 'Students', COUNT(*) FROM core_student
UNION ALL SELECT 'Classes', COUNT(*) FROM core_clazz
UNION ALL SELECT 'Schedules', COUNT(*) FROM core_schedule
UNION ALL SELECT 'Enrollments', COUNT(*) FROM core_enrollment
UNION ALL SELECT 'Attendance Records', COUNT(*) FROM core_attendance
UNION ALL SELECT 'Feedback Entries', COUNT(*) FROM core_feedback
UNION ALL SELECT 'Announcements', COUNT(*) FROM core_announcement
UNION ALL SELECT 'Assignments', COUNT(*) FROM core_assignment
UNION ALL SELECT 'Assignment Submissions', COUNT(*) FROM core_assignmentsubmission
UNION ALL SELECT 'Materials', COUNT(*) FROM core_material
UNION ALL SELECT 'Attendance Sessions', COUNT(*) FROM core_attendancesession;

GO
