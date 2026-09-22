-- Test Data Population Script for College of Science and Technology (COST)
-- This script will insert Professors, Students, Courses, Class Sections, and Enrollments

SET @cost_school_id = (SELECT id FROM schools WHERE school_name = 'College of Science and Technology' LIMIT 1);

-- 1. Insert 5 Professors
INSERT IGNORE INTO users (user_identifier, password, full_name, email, role, major, is_verified, is_active) VALUES
('P101', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Dr. Alan Turing', 'alan@unitrs.edu', 'PROFESSOR', 'Computer Science', TRUE, TRUE),
('P102', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Dr. Grace Hopper', 'grace@unitrs.edu', 'PROFESSOR', 'Software Engineering', TRUE, TRUE),
('P103', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Dr. John von Neumann', 'john@unitrs.edu', 'PROFESSOR', 'Mathematics', TRUE, TRUE),
('P104', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Dr. Ada Lovelace', 'ada@unitrs.edu', 'PROFESSOR', 'Algorithms', TRUE, TRUE),
('P105', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Dr. Tim Berners-Lee', 'tim@unitrs.edu', 'PROFESSOR', 'Web Technologies', TRUE, TRUE);

-- 2. Insert 10 Students for COST
INSERT IGNORE INTO users (user_identifier, password, full_name, email, role, major, is_verified, is_active, student_school_id) VALUES
('S201', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Alice Smith', 'alice@unitrs.edu', 'STUDENT', 'Computer Science', TRUE, TRUE, @cost_school_id),
('S202', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Bob Johnson', 'bob@unitrs.edu', 'STUDENT', 'Software Engineering', TRUE, TRUE, @cost_school_id),
('S203', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Charlie Davis', 'charlie@unitrs.edu', 'STUDENT', 'Computer Science', TRUE, TRUE, @cost_school_id),
('S204', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Diana Evans', 'diana@unitrs.edu', 'STUDENT', 'Information Technology', TRUE, TRUE, @cost_school_id),
('S205', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Evan Frank', 'evan@unitrs.edu', 'STUDENT', 'Cybersecurity', TRUE, TRUE, @cost_school_id),
('S206', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Fiona Green', 'fiona@unitrs.edu', 'STUDENT', 'Computer Science', TRUE, TRUE, @cost_school_id),
('S207', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'George Hall', 'george@unitrs.edu', 'STUDENT', 'Software Engineering', TRUE, TRUE, @cost_school_id),
('S208', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Hannah Ivers', 'hannah@unitrs.edu', 'STUDENT', 'Information Technology', TRUE, TRUE, @cost_school_id),
('S209', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Ian Jones', 'ian@unitrs.edu', 'STUDENT', 'Cybersecurity', TRUE, TRUE, @cost_school_id),
('S210', '$2a$12$3PcEw7rrb4hzSvmmVeYsy.zgG9XBMTuQFd5wf.bYSPeaZ0FUGNd0G', 'Julia King', 'julia@unitrs.edu', 'STUDENT', 'Computer Science', TRUE, TRUE, @cost_school_id);

-- 3. Insert 5 Courses for COST
INSERT IGNORE INTO courses (course_code, course_title, school_id, credits) VALUES
('CSC101', 'Introduction to Programming', @cost_school_id, 3),
('CSC201', 'Data Structures and Algorithms', @cost_school_id, 4),
('SWE301', 'Software Engineering Principles', @cost_school_id, 3),
('NET401', 'Computer Networks', @cost_school_id, 3),
('SEC501', 'Cybersecurity Fundamentals', @cost_school_id, 3);

-- 4. Ensure we have a Term and Rooms
INSERT IGNORE INTO terms (term_number, term_name) VALUES (1, 'Fall 2026');
SET @term_id = (SELECT id FROM terms WHERE term_name = 'Fall 2026' LIMIT 1);

INSERT IGNORE INTO rooms (room_number, capacity, floor_number) VALUES
('Room 101', 30, 1),
('Room 102', 30, 1),
('Room 103', 30, 1);

-- 5. Create Class Sections (Scheduling the courses)
SET @room1 = (SELECT id FROM rooms WHERE room_number = 'Room 101' LIMIT 1);
SET @room2 = (SELECT id FROM rooms WHERE room_number = 'Room 102' LIMIT 1);
SET @room3 = (SELECT id FROM rooms WHERE room_number = 'Room 103' LIMIT 1);

SET @prof1 = (SELECT id FROM users WHERE user_identifier = 'P101' LIMIT 1);
SET @prof2 = (SELECT id FROM users WHERE user_identifier = 'P102' LIMIT 1);
SET @prof3 = (SELECT id FROM users WHERE user_identifier = 'P103' LIMIT 1);

SET @course1 = (SELECT id FROM courses WHERE course_code = 'CSC101' LIMIT 1);
SET @course2 = (SELECT id FROM courses WHERE course_code = 'CSC201' LIMIT 1);
SET @course3 = (SELECT id FROM courses WHERE course_code = 'SWE301' LIMIT 1);

INSERT IGNORE INTO class_sections (term_id, course_id, professor_id, room_id, session_shift, days_of_week, academic_year) VALUES
(@term_id, @course1, @prof1, @room1, 'MORNING', 'Mon-Fri', '2026-2027'),
(@term_id, @course2, @prof2, @room2, 'AFTERNOON', 'Mon-Fri', '2026-2027'),
(@term_id, @course3, @prof3, @room3, 'MORNING', 'Sat-Sun', '2026-2027');

-- 6. Enroll Students into the Class Sections
SET @section1 = (SELECT id FROM class_sections WHERE course_id = @course1 LIMIT 1);
SET @section2 = (SELECT id FROM class_sections WHERE course_id = @course2 LIMIT 1);
SET @section3 = (SELECT id FROM class_sections WHERE course_id = @course3 LIMIT 1);

-- Enroll Student 1 in all 3
INSERT IGNORE INTO enrollments (student_id, class_section_id) VALUES
((SELECT id FROM users WHERE user_identifier = 'S201' LIMIT 1), @section1),
((SELECT id FROM users WHERE user_identifier = 'S201' LIMIT 1), @section2),
((SELECT id FROM users WHERE user_identifier = 'S201' LIMIT 1), @section3);

-- Enroll Student 2 in Section 1 and 2
INSERT IGNORE INTO enrollments (student_id, class_section_id) VALUES
((SELECT id FROM users WHERE user_identifier = 'S202' LIMIT 1), @section1),
((SELECT id FROM users WHERE user_identifier = 'S202' LIMIT 1), @section2);

-- Enroll Student 3 in Section 2 and 3
INSERT IGNORE INTO enrollments (student_id, class_section_id) VALUES
((SELECT id FROM users WHERE user_identifier = 'S203' LIMIT 1), @section2),
((SELECT id FROM users WHERE user_identifier = 'S203' LIMIT 1), @section3);

-- Enroll Students 4-10 in Section 1
INSERT IGNORE INTO enrollments (student_id, class_section_id) SELECT id, @section1 FROM users WHERE user_identifier IN ('S204', 'S205', 'S206', 'S207', 'S208', 'S209', 'S210');

-- 7. Insert some dummy grades for Student 1 in Section 1 just to see the transcript working!
INSERT IGNORE INTO grades (enrollment_id, attendance_score, assignment_score, midterm_score, final_score, total_score, letter_grade, gpa_point)
SELECT id, 15, 23, 28, 29, 95, 'A', 4.0
FROM enrollments 
WHERE student_id = (SELECT id FROM users WHERE user_identifier = 'S201' LIMIT 1) 
AND class_section_id = @section1;

ALTER TABLE users ADD COLUMN gender ENUM('MALE', 'FEMALE') NOT NULL DEFAULT 'MALE';
