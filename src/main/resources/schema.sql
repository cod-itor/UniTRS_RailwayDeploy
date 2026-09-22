CREATE DATABASE IF NOT EXISTS unitrs_db;
USE unitrs_db;

-- 1. Academic Schools (Colleges)
CREATE TABLE IF NOT EXISTS schools (
    id INT AUTO_INCREMENT PRIMARY KEY,
    school_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Users Table (Handles Students, Faculty, Deans, and Admins)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_identifier VARCHAR(50) NOT NULL UNIQUE, -- Student ID (e.g. '60-24-04-91') or Staff Username/Email
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role ENUM('STUDENT', 'PROFESSOR', 'DEAN', 'ADMIN') NOT NULL,
    major VARCHAR(100),
    is_verified BOOLEAN DEFAULT FALSE,           -- Requires Admin verification for Students
    is_active BOOLEAN DEFAULT TRUE,
    dean_school_id INT UNIQUE DEFAULT NULL,      -- A user can be the Dean of at most one school
    student_school_id INT DEFAULT NULL,          -- The school a student officially belongs to
    two_factor_enabled BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dean_school_id) REFERENCES schools(id) ON DELETE SET NULL,
    FOREIGN KEY (student_school_id) REFERENCES schools(id) ON DELETE SET NULL
);

-- 3. Terms Master Table
CREATE TABLE IF NOT EXISTS terms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    term_number INT NOT NULL UNIQUE,             -- e.g. 1 through 12
    term_name VARCHAR(50) NOT NULL               -- e.g. 'Term 5'
);

-- 4. Courses Master Table
CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,     -- e.g. 'ITE 204'
    course_title VARCHAR(150) NOT NULL,          -- e.g. 'Java Enterprise Edition'
    credits INT DEFAULT 3,
    school_id INT NOT NULL,
    FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE RESTRICT,
    INDEX idx_courses_school_id (school_id)
);

-- 4. Term Course Bundles (Mapping courses belonging to a specific term)
CREATE TABLE IF NOT EXISTS term_courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    term_id INT NOT NULL,
    course_id INT NOT NULL,
    FOREIGN KEY (term_id) REFERENCES terms(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    UNIQUE KEY uq_term_course (term_id, course_id)
);

-- 5. Rooms (Physical space capacity)
CREATE TABLE IF NOT EXISTS rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(20) NOT NULL UNIQUE,
    floor_number INT NOT NULL,
    capacity INT NOT NULL
);

-- 6. Class Sections (Actual scheduled classes per term, shift, and professor)
CREATE TABLE IF NOT EXISTS class_sections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    term_id INT NOT NULL,
    course_id INT NOT NULL,
    professor_id INT NOT NULL,
    room_id INT NOT NULL,
    session_shift ENUM('MORNING', 'AFTERNOON', 'EVENING', 'WEEKEND') NOT NULL,
    days_of_week VARCHAR(50) NOT NULL,           -- e.g. 'Mon - Fri'
    academic_year VARCHAR(20) NOT NULL,          -- e.g. '2025-2026'
    FOREIGN KEY (term_id) REFERENCES terms(id) ON DELETE RESTRICT,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE RESTRICT,
    FOREIGN KEY (professor_id) REFERENCES users(id) ON DELETE RESTRICT,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE RESTRICT,
    INDEX idx_class_sections_term_id (term_id),
    INDEX idx_class_sections_course_id (course_id),
    INDEX idx_class_sections_professor_id (professor_id),
    INDEX idx_class_sections_academic_year (academic_year)
);


-- 6. Student Enrollments
CREATE TABLE IF NOT EXISTS enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    class_section_id INT NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (class_section_id) REFERENCES class_sections(id) ON DELETE CASCADE,
    UNIQUE KEY uq_student_section (student_id, class_section_id),
    INDEX idx_enrollments_student_id (student_id),
    INDEX idx_enrollments_class_section_id (class_section_id)
);

-- 7. Attendance Records Table
CREATE TABLE IF NOT EXISTS attendance_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_section_id INT NOT NULL,
    session_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_section_date (class_section_id, session_date),
    FOREIGN KEY (class_section_id) REFERENCES class_sections(id) ON DELETE CASCADE
);

-- 8. Attendance Entries Table (Individual student attendance)
CREATE TABLE IF NOT EXISTS attendance_entries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    attendance_record_id INT NOT NULL,
    student_id INT NOT NULL,
    status ENUM('PRESENT', 'ABSENT', 'LATE', 'EXCUSED') NOT NULL,
    FOREIGN KEY (attendance_record_id) REFERENCES attendance_records(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY uq_record_student (attendance_record_id, student_id)
);

-- 9. Assessment & Grades Table
CREATE TABLE IF NOT EXISTS grades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL UNIQUE,
    attendance_score DECIMAL(5,2) DEFAULT 0.00,  -- Max 15
    assignment_score DECIMAL(5,2) DEFAULT 0.00,  -- Max 25
    midterm_score DECIMAL(5,2) DEFAULT 0.00,     -- Max 30
    final_score DECIMAL(5,2) DEFAULT 0.00,       -- Max 30
    total_score DECIMAL(5,2) DEFAULT 0.00,       -- Max 100
    letter_grade VARCHAR(2) DEFAULT 'F',
    gpa_point DECIMAL(3,2) DEFAULT 0.00,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(id) ON DELETE CASCADE
);

-- 10. OTP Verifications Table (Handles Email OTPs for Registration, 2FA, and Password Reset)
CREATE TABLE IF NOT EXISTS otp_verifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    otp_code VARCHAR(6) NOT NULL,
    otp_type ENUM('REGISTRATION', 'LOGIN_2FA', 'PASSWORD_RESET') NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    is_used BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email_type_used (email, otp_type, is_used)
);

-- ==============================================
-- DATABASE OPTIMIZATIONS (Indexes & Views)
-- ==============================================

-- 1. Strategic Indexing for High-Performance Queries
-- (Indexes have been moved into their respective CREATE TABLE definitions to ensure idempotency)

-- 2. Flat View for Student Schedules
CREATE OR REPLACE VIEW student_schedule_view AS
SELECT 
    e.id AS enrollment_id,
    e.student_id,
    e.class_section_id,
    c.course_code,
    c.course_title,
    c.credits,
    t.term_name,
    cs.session_shift,
    cs.days_of_week,
    cs.academic_year,
    r.room_number,
    p.full_name AS professor_name
FROM enrollments e
JOIN class_sections cs ON e.class_section_id = cs.id
JOIN courses c ON cs.course_id = c.id
JOIN terms t ON cs.term_id = t.id
JOIN rooms r ON cs.room_id = r.id
JOIN users p ON cs.professor_id = p.id;

-- Seed Initial Terms
INSERT IGNORE INTO terms (term_number, term_name) VALUES
(1, 'Term 1'), (2, 'Term 2'), (3, 'Term 3'), (4, 'Term 4'),
(5, 'Term 5'), (6, 'Term 6'), (7, 'Term 7'), (8, 'Term 8');

-- Seed Initial Schools
INSERT IGNORE INTO schools (school_name) VALUES
('School of Undergraduate Studies'),
('School of Graduate Studies'),
('College of Arts and Humanities'),
('College of Education'),
('College of Law'),
('College of Media and Communications'),
('College of Science and Technology'),
('College of Social Sciences'),
('School of Creative Arts'),
('School of Foreign Languages'),
('The Techo Sen School of Government and International Relations'),
('School of Business');

-- Seed Initial Courses
INSERT IGNORE INTO courses (course_code, course_title, credits, school_id) VALUES
('ITE 204', 'Java Enterprise Edition', 3, 7),
('ITE 205', 'Database Systems Administration', 3, 7),
('ITE 206', 'Computer Networks', 3, 7),
('ENG 201', 'Advanced Academic English', 3, 10);

-- Seed Initial Staff Roles (Verified staff accounts)
-- Passwords are BCrypt-hashed: admin123, dean123, prof123
INSERT IGNORE INTO users (user_identifier, password, full_name, email, role, major, is_verified, is_active, dean_school_id) VALUES
('admin', '$2a$12$yDvhSPnM7Ne8VReersrfNunoFcOlm1qt78L0/9bQlc6zusej5PBNO', 'System Administrator', 'admin@unitrs.edu', 'ADMIN', 'IT Infrastructure', TRUE, TRUE, NULL),
('dean@unitrs.edu', '$2a$12$xvvaVuiH2ZXkzauGFnMM8OG57jEXbSRy4tSIqFHmJYMXQToZJhl.a', 'Dean of Science and Tech', 'dean@unitrs.edu', 'PROFESSOR', 'Computer Science', TRUE, TRUE, 7),
('prof.sok@unitrs.edu', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Prof. Sok Chan', 'prof.sok@unitrs.edu', 'PROFESSOR', 'Computer Science', TRUE, TRUE, NULL);