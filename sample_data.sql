-- SCRIPT BẮT BUỘC CHẠY SAU: CHÈN DỮ LIỆU (DML)

-- --- KHỞI TẠO BIẾN ---
DECLARE @NOW DATETIME2 = GETDATE();
DECLARE @i INT;
DECLARE @enrollment_count INT = 0;
DECLARE @num_teachers INT = 30;
DECLARE @num_staff INT = 25;
DECLARE @num_students INT = 30;
DECLARE @num_classtypes INT = 5;
DECLARE @num_classes INT = 15;

DECLARE @new_user_id INT; -- Variable to store the newly created user ID

-- --- CLEANUP AND RESET (CRITICAL FIX) ---
PRINT '--- Cleaning up old data and resetting identities ---';
DELETE FROM dbo.core_feedback;
DELETE FROM dbo.core_attendance;
DELETE FROM dbo.core_enrollment;
DELETE FROM dbo.core_schedule;
DELETE FROM dbo.core_clazz;
DELETE FROM dbo.core_classtype;
DELETE FROM dbo.core_student;
DELETE FROM dbo.core_staff;
DELETE FROM dbo.core_teacher;

-- Only delete users that look like sample data to avoid deleting admin
DELETE FROM dbo.auth_user WHERE username LIKE 'student%' OR username LIKE 'teacher%' OR username LIKE 'staff%';

-- Reset Identity Counters so IDs start at 1 again
DBCC CHECKIDENT ('dbo.core_student', RESEED, 0);
DBCC CHECKIDENT ('dbo.core_teacher', RESEED, 0);
DBCC CHECKIDENT ('dbo.core_staff', RESEED, 0);
DBCC CHECKIDENT ('dbo.core_clazz', RESEED, 0);
DBCC CHECKIDENT ('dbo.core_classtype', RESEED, 0);
DBCC CHECKIDENT ('dbo.core_enrollment', RESEED, 0);
DBCC CHECKIDENT ('dbo.core_attendance', RESEED, 0);
DBCC CHECKIDENT ('dbo.core_feedback', RESEED, 0);


-- 1 & 4. INSERT INTO dbo.auth_user AND dbo.core_student (Combined for ID safety)
PRINT '--- 1 & 4. Generating data for dbo.auth_user and dbo.core_student (30 records) ---';
SET @i = 1;
WHILE @i <= @num_students
BEGIN
    -- Insert User
    INSERT INTO dbo.auth_user (username, email, password, date_joined, is_active, is_staff, is_superuser, first_name, last_name) VALUES
    ('student' + CAST(@i AS VARCHAR(5)), 'student' + CAST(@i AS VARCHAR(5)) + '@school.edu', 
     'pbkdf2_sha256$260000$xxxx', 
     DATEADD(DAY, -@i, @NOW), 
     1, 0, 0, 
     N'Tên_' + CAST(@i AS NVARCHAR(5)), N'Học_sinh');
     
    -- Capture the actual User ID
    SET @new_user_id = SCOPE_IDENTITY();

    -- Insert Student using the captured User ID
    -- Student ID will be 1, 2, 3... because we reseeded
    INSERT INTO dbo.core_student (user_id, full_name, dob, phone_number, email, address, created_at, updated_at) VALUES
    (@new_user_id, 
     N'Học sinh Trần Văn ' + CAST(@i AS NVARCHAR(5)), 
     DATEADD(YEAR, -18 - (@i % 5), '2000-01-01'), 
     '07012345' + FORMAT(@i, 'D2'), 
     'student' + CAST(@i AS VARCHAR(5)) + '@school.edu', 
     N'789 Đường Sinh Viên, Quận ' + CAST((@i % 7) + 1 AS NVARCHAR(5)),
     DATEADD(DAY, -@i * 5, @NOW), @NOW);
     
    SET @i = @i + 1;
END;


-- 2. INSERT INTO dbo.core_teacher (30 records)
PRINT '--- 2. Generating data for dbo.core_teacher (30 records) ---';
SET @i = 1;
WHILE @i <= @num_teachers
BEGIN
    INSERT INTO dbo.core_teacher (full_name, dob, phone_number, email, address, qualification, created_at, updated_at) VALUES
    (N'Giáo viên Nguyễn Văn ' + CAST(@i AS NVARCHAR(5)), 
     DATEADD(YEAR, -30 - (@i % 10), '1990-01-01'), 
     '09012345' + FORMAT(@i, 'D2'), 
     'teacher' + CAST(@i AS VARCHAR(5)) + '@school.edu', 
     N'123 Đường Sư Phạm, Khu vực ' + CAST((@i % 5) + 1 AS NVARCHAR(5)), 
     CASE 
        WHEN @i % 3 = 0 THEN N'Thạc sĩ CNTT'
        WHEN @i % 3 = 1 THEN N'Cử nhân Ngôn ngữ Anh'
        ELSE N'Tiến sĩ Toán học Ứng dụng'
     END,
     DATEADD(DAY, -@i * 10, @NOW), @NOW);
    SET @i = @i + 1;
END;

-- 3. INSERT INTO dbo.core_staff (25 records)
PRINT '--- 3. Generating data for dbo.core_staff (25 records) ---';
SET @i = 1;
WHILE @i <= @num_staff
BEGIN
    INSERT INTO dbo.core_staff (full_name, dob, phone_number, email, address, position, created_at, updated_at) VALUES
    (N'Nhân viên Lê Thị ' + CAST(@i AS NVARCHAR(5)), 
     DATEADD(YEAR, -25 - (@i % 5), '1995-01-01'), 
     '08012345' + FORMAT(@i, 'D2'), 
     'staff' + CAST(@i AS VARCHAR(5)) + '@school.edu', 
     N'456 Đường Quản Lý, Khu vực ' + CAST((@i % 4) + 1 AS NVARCHAR(5)),
     CASE 
        WHEN @i % 4 = 0 THEN N'Kế toán trưởng'
        WHEN @i % 4 = 1 THEN N'Tư vấn tuyển sinh'
        WHEN @i % 4 = 2 THEN N'Quản lý cơ sở vật chất'
        ELSE N'Hành chính văn phòng'
     END,
     DATEADD(DAY, -@i * 15, @NOW), @NOW);
    SET @i = @i + 1;
END;

-- 5. INSERT INTO dbo.core_classtype (5 records)
PRINT '--- 5. Generating data for dbo.core_classtype (5 records) ---';
INSERT INTO dbo.core_classtype (code, description, created_at, updated_at) VALUES
('IT_ADV', N'Các khóa học chuyên sâu về Lập trình, Khoa học dữ liệu, và AI.', @NOW, @NOW),
('LANG_A', N'Các khóa học Ngôn ngữ cơ bản (A1-B1) như Tiếng Anh, Nhật, Hàn.', @NOW, @NOW),
('MATH_PRE', N'Các lớp luyện thi Đại học, chuyên sâu về Toán và Lý.', @NOW, @NOW),
('ART_DES', N'Các khóa học về Thiết kế đồ họa, Vẽ kỹ thuật số và Sáng tạo nội dung.', @NOW, @NOW),
('BUSI_SKILL', N'Các lớp kỹ năng mềm, Quản lý dự án, và Kinh doanh cơ bản.', @NOW, @NOW);

-- 6. INSERT INTO dbo.core_clazz (15 records)
PRINT '--- 6. Generating data for dbo.core_clazz (15 records) ---';
DECLARE @class_type_id INT;
SET @i = 1;
WHILE @i <= @num_classes
BEGIN
    SET @class_type_id = (@i % @num_classtypes) + 1;

    INSERT INTO dbo.core_clazz (class_name, class_type_id, teacher_id, staff_id, start_date, end_date, price, room, image, created_at, updated_at) VALUES
    (N'Lớp ' + 
     CASE 
        WHEN @i % 5 = 1 THEN N'Python Cơ bản K'
        WHEN @i % 5 = 2 THEN N'Giao tiếp Tiếng Anh A2 K'
        WHEN @i % 5 = 3 THEN N'Giải tích Luyện đề K'
        WHEN @i % 5 = 4 THEN N'Thiết kế UI/UX K'
        ELSE N'Quản lý Dự án Agile K'
     END + CAST(@i AS NVARCHAR(5)),
     @class_type_id,
     (@i % @num_teachers) + 1, 
     (@i % @num_staff) + 1,      
     DATEADD(DAY, (@i - 1) * 30, '2024-09-01'),
     DATEADD(DAY, (@i - 1) * 30 + 90, '2024-09-01'), 
     5000000.00 + (@i * 150000.00), 
     'P' + FORMAT(@i, 'D2') + '.101', 
     'class_images/default_class.png', 
     DATEADD(DAY, -30 - @i, @NOW), @NOW);
    SET @i = @i + 1;
END;


-- 7. INSERT INTO dbo.core_schedule (15 records - one for each core_clazz)
PRINT '--- 7. Generating data for dbo.core_schedule (15 records) ---';
SET @i = 1;
WHILE @i <= @num_classes
BEGIN
    INSERT INTO dbo.core_schedule (clazz_id, day_of_week, start_time, end_time, created_at, updated_at) VALUES
    (@i, 
     CASE 
        WHEN @i % 3 = 1 THEN N'Thứ 2, Thứ 4, Thứ 6'
        WHEN @i % 3 = 2 THEN N'Thứ 3, Thứ 5, Thứ 7'
        ELSE N'Thứ 7, Chủ Nhật'
     END,
     CASE WHEN @i % 2 = 1 THEN '18:30:00' ELSE '09:00:00' END,
     CASE WHEN @i % 2 = 1 THEN '20:30:00' ELSE '11:00:00' END,
     DATEADD(DAY, -20 - @i, @NOW), @NOW);
    SET @i = @i + 1;
END;


-- 8. INSERT INTO dbo.core_enrollment (Approx. 150 records)
PRINT '--- 8. Generating data for dbo.core_enrollment (~150 records) ---';
DECLARE @student_id INT, @clazz_id INT;
SET @enrollment_count = 0; 
SET @student_id = 1;
WHILE @student_id <= @num_students
BEGIN
    DECLARE @classes_to_enroll INT = 
        CASE 
            WHEN @student_id <= 10 THEN 5 
            WHEN @student_id <= 20 THEN 4 
            ELSE 2                      
        END;
    
    SET @i = 1;
    WHILE @i <= @classes_to_enroll
    BEGIN
        SET @clazz_id = (@student_id * @i) % @num_classes + 1;
        
        IF NOT EXISTS (SELECT 1 FROM dbo.core_enrollment WHERE student_id = @student_id AND clazz_id = @clazz_id)
        BEGIN
            INSERT INTO dbo.core_enrollment (student_id, clazz_id, enrollment_date, minitest1, minitest2, midterm, final_test, created_at, updated_at) VALUES
            (@student_id, @clazz_id, DATEADD(DAY, -@i * 10, GETDATE()), 
             ROUND(RAND(CHECKSUM(NEWID())) * 10, 1), 
             ROUND(RAND(CHECKSUM(NEWID())) * 10, 1), 
             ROUND(RAND(CHECKSUM(NEWID())) * 10, 1),
             CASE WHEN @student_id % 3 = 0 THEN ROUND(RAND(CHECKSUM(NEWID())) * 10, 1) ELSE NULL END, 
             DATEADD(DAY, -@i * 10, @NOW), @NOW); 
            SET @enrollment_count = @enrollment_count + 1;
        END
        SET @i = @i + 1;
    END
    SET @student_id = @student_id + 1;
END;
PRINT 'Total dbo.core_enrollment inserted: ' + CAST(@enrollment_count AS VARCHAR(10));


-- 9. INSERT INTO dbo.core_attendance (Approx. 300 records)
PRINT '--- 9. Generating data for dbo.core_attendance (~300 records) ---';
DECLARE @enrollment_id_att INT, @date DATE, @status VARCHAR(20), @attendance_count INT = 0;
SET @i = 1;
WHILE @i <= 300
BEGIN
    SELECT TOP 1 @enrollment_id_att = enrollment_id FROM dbo.core_enrollment ORDER BY NEWID();
    
    SET @date = DATEADD(DAY, -(@i % 30), GETDATE()); 
    
    SET @status = 
        CASE 
            WHEN RAND(CHECKSUM(NEWID())) < 0.85 THEN 'Present' 
            WHEN RAND(CHECKSUM(NEWID())) < 0.95 THEN 'Absent' 
            ELSE 'Excused' 
        END;

    IF NOT EXISTS (SELECT 1 FROM dbo.core_attendance WHERE enrollment_id = @enrollment_id_att AND date = @date)
    BEGIN
        INSERT INTO dbo.core_attendance (enrollment_id, date, status, created_at, updated_at) VALUES
        (@enrollment_id_att, @date, @status, DATEADD(HOUR, -1, @NOW), @NOW);
        SET @attendance_count = @attendance_count + 1;
    END
    SET @i = @i + 1;
END;
PRINT 'Total dbo.core_attendance records inserted: ' + CAST(@attendance_count AS VARCHAR(10));


-- 10. INSERT INTO dbo.core_feedback (Approx. 100 records)
PRINT '--- 10. Generating data for dbo.core_feedback (~100 records) ---';
DECLARE @f_student_id INT, @f_clazz_id INT, @f_teacher_id INT, @feedback_count INT = 0;
SET @i = 1;
WHILE @i <= 100
BEGIN
    SELECT TOP 1 @f_student_id = student_id, @f_clazz_id = clazz_id FROM dbo.core_enrollment ORDER BY NEWID();
    
    SELECT @f_teacher_id = teacher_id FROM dbo.core_clazz WHERE class_id = @f_clazz_id;

    IF @f_teacher_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.core_feedback WHERE student_id = @f_student_id AND clazz_id = @f_clazz_id)
    BEGIN
        INSERT INTO dbo.core_feedback (student_id, teacher_id, clazz_id, teacher_rate, class_rate, created_at, updated_at) VALUES
        (@f_student_id, @f_teacher_id, @f_clazz_id, 
         ROUND(RAND(CHECKSUM(NEWID())) * 5 + 5, 2), 
         ROUND(RAND(CHECKSUM(NEWID())) * 5 + 5, 2),
         DATEADD(DAY, -(@i % 60), @NOW), @NOW);
        SET @feedback_count = @feedback_count + 1;
    END
    SET @i = @i + 1;
END;
PRINT 'Total dbo.core_feedback records inserted: ' + CAST(@feedback_count AS VARCHAR(10));
PRINT '*** DML Script execution finished. ***';