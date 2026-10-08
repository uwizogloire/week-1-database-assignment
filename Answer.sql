-- ======================================================
-- Week 1 Assignment: MySQL Database Creation
-- Topic: School Management System
-- Database Name: school_management_db
-- Description: Manages students, teachers, courses and enrollments
-- Created for: PLP Academy - Introduction to SQL
-- Student: Uwizo
-- ======================================================

-- 1. Create the database
DROP DATABASE IF EXISTS school_management_db;
CREATE DATABASE school_management_db;
USE school_management_db;

-- 2. Create Tables

-- Table: Students
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    enrollment_date DATE DEFAULT (CURRENT_DATE)
);

-- Table: Teachers
CREATE TABLE Teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50) NOT NULL,
    hire_date DATE DEFAULT (CURRENT_DATE)
);

-- Table: Courses
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    teacher_id INT,
    credits INT DEFAULT 3,
    description TEXT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Table: Enrollments (Links Students and Courses - Many-to-Many)
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE(student_id, course_id) -- A student can't enroll twice in same course
);

-- 3. Insert Sample Data

-- Insert Teachers
INSERT INTO Teachers (first_name, last_name, email, department, hire_date) VALUES
('Grace', 'Mukamana', 'grace.mukamana@school.com', 'Computer Science', '2022-01-15'),
('James', 'Otieno', 'james.otieno@school.com', 'Mathematics', '2021-08-20'),
('Aisha', 'Kagwa', 'aisha.kagwa@school.com', 'Business Studies', '2023-03-10');

-- Insert Students
INSERT INTO Students (first_name, last_name, email, date_of_birth, gender) VALUES
('Uwizo', 'Keza', 'uwizo.keza@student.com', '2002-05-14', 'Female'),
('Brian', 'Mwangi', 'brian.mwangi@student.com', '2001-11-22', 'Male'),
('Linda', 'Uwase', 'linda.uwase@student.com', '2003-02-08', 'Female'),
('David', 'Njoroge', 'david.njoroge@student.com', '2000-07-30', 'Male'),
('Esther', 'Akello', 'esther.akello@student.com', '2002-09-12', 'Female');

-- Insert Courses
INSERT INTO Courses (course_name, course_code, teacher_id, credits, description) VALUES
('Introduction to SQL', 'CS101', 1, 3, 'Fundamentals of MySQL databases and SQL queries'),
('Calculus I', 'MATH101', 2, 4, 'Basic calculus and analytical geometry'),
('Entrepreneurship Basics', 'BUS101', 3, 3, 'Introduction to business and startups'),
('Data Structures', 'CS102', 1, 4, 'Arrays, lists, trees and graphs');

-- Insert Enrollments
INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B+'),
(2, 1, 'A-'),
(2, 4, 'B'),
(3, 3, 'A'),
(4, 1, 'B'),
(5, 2, 'A'),
(5, 3, 'B+');

-- 4. Verification Queries (to show your work)
SHOW TABLES;
SELECT * FROM Students;
SELECT * FROM Teachers;
SELECT * FROM Courses;
SELECT s.first_name, s.last_name, c.course_name, e.grade 
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;
