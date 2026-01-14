-- ============================================
-- EduManage - Constraints and Rules Setup Script
-- Based on PRESENTATION_CONTENT.md
-- Run this script AFTER Django migrations
-- ============================================

USE ClassManagementWebsite;
GO

-- ============================================
-- CHECK CONSTRAINTS
-- ============================================

-- Enrollment Status: Only 'pending', 'approved', 'rejected'
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Enrollment_Status')
BEGIN
    ALTER TABLE core_enrollment
    ADD CONSTRAINT CK_Enrollment_Status 
    CHECK (status IN ('pending', 'approved', 'rejected'));
    PRINT 'Added: CK_Enrollment_Status';
END
GO

-- Attendance Status: Only 'Present', 'Absent', 'Excused'
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Attendance_Status')
BEGIN
    ALTER TABLE core_attendance
    ADD CONSTRAINT CK_Attendance_Status 
    CHECK (status IN ('Present', 'Absent', 'Excused'));
    PRINT 'Added: CK_Attendance_Status';
END
GO

-- Feedback Teacher Rating: Must be between 1 and 10
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Feedback_TeacherRate')
BEGIN
    ALTER TABLE core_feedback
    ADD CONSTRAINT CK_Feedback_TeacherRate 
    CHECK (teacher_rate >= 1 AND teacher_rate <= 10);
    PRINT 'Added: CK_Feedback_TeacherRate';
END
GO

-- Feedback Class Rating: Must be between 1 and 10
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Feedback_ClassRate')
BEGIN
    ALTER TABLE core_feedback
    ADD CONSTRAINT CK_Feedback_ClassRate 
    CHECK (class_rate >= 1 AND class_rate <= 10);
    PRINT 'Added: CK_Feedback_ClassRate';
END
GO

-- Enrollment Grades: Mini tests, midterm, final must be 0-10
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Enrollment_Minitest1')
BEGIN
    ALTER TABLE core_enrollment
    ADD CONSTRAINT CK_Enrollment_Minitest1 CHECK (minitest1 IS NULL OR (minitest1 >= 0 AND minitest1 <= 10));
    PRINT 'Added: CK_Enrollment_Minitest1';
END
GO

IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Enrollment_Minitest2')
BEGIN
    ALTER TABLE core_enrollment
    ADD CONSTRAINT CK_Enrollment_Minitest2 CHECK (minitest2 IS NULL OR (minitest2 >= 0 AND minitest2 <= 10));
    PRINT 'Added: CK_Enrollment_Minitest2';
END
GO

IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Enrollment_Minitest3')
BEGIN
    ALTER TABLE core_enrollment
    ADD CONSTRAINT CK_Enrollment_Minitest3 CHECK (minitest3 IS NULL OR (minitest3 >= 0 AND minitest3 <= 10));
    PRINT 'Added: CK_Enrollment_Minitest3';
END
GO

IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Enrollment_Minitest4')
BEGIN
    ALTER TABLE core_enrollment
    ADD CONSTRAINT CK_Enrollment_Minitest4 CHECK (minitest4 IS NULL OR (minitest4 >= 0 AND minitest4 <= 10));
    PRINT 'Added: CK_Enrollment_Minitest4';
END
GO

IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Enrollment_Midterm')
BEGIN
    ALTER TABLE core_enrollment
    ADD CONSTRAINT CK_Enrollment_Midterm CHECK (midterm IS NULL OR (midterm >= 0 AND midterm <= 10));
    PRINT 'Added: CK_Enrollment_Midterm';
END
GO

IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Enrollment_FinalTest')
BEGIN
    ALTER TABLE core_enrollment
    ADD CONSTRAINT CK_Enrollment_FinalTest CHECK (final_test IS NULL OR (final_test >= 0 AND final_test <= 10));
    PRINT 'Added: CK_Enrollment_FinalTest';
END
GO

-- Class Price: Must be positive
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Clazz_Price')
BEGIN
    ALTER TABLE core_clazz
    ADD CONSTRAINT CK_Clazz_Price 
    CHECK (price >= 0);
    PRINT 'Added: CK_Clazz_Price';
END
GO

-- Class Dates: End date must be after start date
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Clazz_Dates')
BEGIN
    ALTER TABLE core_clazz
    ADD CONSTRAINT CK_Clazz_Dates 
    CHECK (end_date >= start_date);
    PRINT 'Added: CK_Clazz_Dates';
END
GO

-- Class Times: End time must be after start time
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Clazz_Times')
BEGIN
    ALTER TABLE core_clazz
    ADD CONSTRAINT CK_Clazz_Times 
    CHECK (end_time > start_time);
    PRINT 'Added: CK_Clazz_Times';
END
GO

-- AttendanceSession Passcode: Must be 4 digits
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_AttendanceSession_Passcode')
BEGIN
    ALTER TABLE core_attendancesession
    ADD CONSTRAINT CK_AttendanceSession_Passcode 
    CHECK (LEN(passcode) = 4 AND passcode LIKE '[0-9][0-9][0-9][0-9]');
    PRINT 'Added: CK_AttendanceSession_Passcode';
END
GO

-- ============================================
-- VERIFY UNIQUE CONSTRAINTS (Created by Django)
-- ============================================

PRINT '';
PRINT '=== Existing Unique Constraints ===';

SELECT 
    tc.TABLE_NAME,
    tc.CONSTRAINT_NAME,
    STRING_AGG(ccu.COLUMN_NAME, ', ') AS COLUMNS
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu 
    ON tc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_TYPE = 'UNIQUE'
GROUP BY tc.TABLE_NAME, tc.CONSTRAINT_NAME
ORDER BY tc.TABLE_NAME;

-- ============================================
-- SUMMARY
-- ============================================

PRINT '';
PRINT '=== All CHECK Constraints ===';

SELECT 
    OBJECT_NAME(parent_object_id) AS TableName,
    name AS ConstraintName,
    definition AS ConstraintDefinition
FROM sys.check_constraints
WHERE OBJECT_NAME(parent_object_id) LIKE 'core_%'
ORDER BY TableName, name;

PRINT '';
PRINT 'Constraints setup completed!';
GO
