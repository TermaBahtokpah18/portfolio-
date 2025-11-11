
CREATE DATABASE IF NOT EXISTS ucu_records;
USE ucu_records;

-- Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('Male', 'Female'),
    dob DATE,
    email VARCHAR(100),
    program VARCHAR(100),
    year_of_study INT
);

-- Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credit_units INT,
     instructor VARCHAR(100)
);

-- Registrations Table
CREATE TABLE registrations (
    registration_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    academic_year VARCHAR(9),
    semester ENUM('1', '2'),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Grades Table
CREATE TABLE grades (
    grade_id INT PRIMARY KEY,
    registration_id INT,
    marks DECIMAL(5,2),
    grade VARCHAR(2),
    FOREIGN KEY (registration_id) REFERENCES registrations(registration_id)
);

INSERT INTO students VALUES
(1, 'Alice', 'Johnson', 'Female', '2003-05-10', 'alice@ucu.ac.ug', 'Computer Science', 2),
(2, 'Bob', 'Smith', 'Male', '2002-09-22', 'bob@ucu.ac.ug', 'Software Engineering', 3),
(3, 'Carol', 'Brown', 'Female', '2004-01-15', 'carol@ucu.ac.ug', 'IT', 1),
(4, 'David', 'Lee', 'Male', '2003-12-05', 'david@ucu.ac.ug', 'Computer Science', 2),
(5, 'Eva', 'White', 'Female', '2002-03-28', 'eva@ucu.ac.ug', 'Cyber Security', 4),
(6, 'Frank', 'Green', 'Male', '2003-07-11', 'frank@ucu.ac.ug', 'Computer Science', 2),
(7, 'Grace', 'Black', 'Female', '2001-11-02', 'grace@ucu.ac.ug', 'Software Engineering', 3),
(8, 'Henry', 'Adams', 'Male', '2002-08-14', 'henry@ucu.ac.ug', 'IT', 2),
(9, 'Ivy', 'Clark', 'Female', '2003-06-18', 'ivy@ucu.ac.ug', 'Computer Science', 1),
(10, 'Jack', 'Davis', 'Male', '2004-02-23', 'jack@ucu.ac.ug', 'Cyber Security', 1);

-- Insert Courses
INSERT INTO courses VALUES
(101, 'Database Systems', 3, 'Dr. Kim'),
(102, 'Computer Networks', 4, 'Prof. Nsubuga'),
(103, 'Data Structures', 3, 'Ms. Achieng'),
(104, 'Web Development', 3, 'Mr. Okello'),
(105, 'Cyber Security Fundamentals', 4, 'Dr. Mbabazi');

-- Insert Registrations
INSERT INTO registrations VALUES
(1, 1, 101, '2024/2025', '1'),
(2, 1, 102, '2024/2025', '2'),
(3, 2, 101, '2024/2025', '1'),
(4, 2, 103, '2024/2025', '2'),
(5, 3, 101, '2024/2025', '1'),
(6, 3, 104, '2024/2025', '2'),
(7, 4, 102, '2024/2025', '1'),
(8, 4, 105, '2024/2025', '2'),
(9, 5, 101, '2024/2025', '2'),
(10, 5, 104, '2024/2025', '1'),
(11, 6, 101, '2024/2025', '1'),
(12, 6, 102, '2024/2025', '2'),
(13, 7, 103, '2024/2025', '1'),
(14, 7, 105, '2024/2025', '2'),
(15, 8, 104, '2024/2025', '2'),
(16, 9, 102, '2024/2025', '1'),
(17, 9, 105, '2024/2025', '2'),
(18, 10, 101, '2024/2025', '1'),
(19, 10, 103, '2024/2025', '2'),
(20, 2, 104, '2024/2025', '1');

-- Insert Grades
INSERT INTO grades VALUES
(1, 1, 85, 'A'),
(2, 2, 74, 'B'),
(3, 3, 92, 'A'),
(4, 4, 65, 'C'),
(5, 5, 40, 'F'),
(6, 6, 70, 'B'),
(7, 7, 77, 'B'),
(8, 8, 68, 'C'),
(9, 9, 50, 'D'),
(10, 10, 55, 'C'),
(11, 11, 88, 'A'),
(12, 12, 46, 'F'),
(13, 13, 81, 'A'),
(14, 14, 90, 'A'),
(15, 15, 33, 'F'),
(16, 16, 60, 'C'),
(17, 17, 49, 'F'),
(18, 18, 79, 'B'),
(19, 19, 58, 'C'),
(20, 20, 84, 'A');

select
STUDENTS.Student_ID,
STUDENTS.FirstName,
STUDENTS.LastName,
STUDENTS.Gender,
STUDENTS.Program,
STUDENTS.Year_of_study,
STUDENTS.Email
from
STUDENTS
join REGISTRATION on STUDENTS.Student_ID = REGISTRATION.Student_ID
group by
STUDENTS.Student_ID,
STUDENTS.FirstName,
STUDENTS.LastName,
STUDENTS.Gender,
STUDENTS.Program,
STUDENTS.Year_of_study,
STUDENTS.Email
HAVING
count(REGISTRATION.Course_ID)>2;

Select
STUDENTS.Student_ID,
STUDENTS.FirstName,
STUDENTS.LastName,
COURSE.Course_name,
GRADES.Grade
from
STUDENTS
Join REGISTRATION ON STUDENTS.Student_ID = REGISTRATION.Student_ID
Join COURSE ON REGISTRATION.Course_ID = COURSE.Course_ID
Join GRADES ON REGISTRATION.Registration_ID = GRADES.Registration_ID
Order by
STUDENTS.student_ID;

SELECT
COURSE.Course_name,
avg(GRADES.MARKS) as average_mark
from COURSE
join  REGISTRATION on COURSE.Course_ID = REGISTRATION.Course_ID
join GRADES on REGISTRATION.Registration_ID = GRADES.Registration_ID
group by
COURSE.Course_ID;

select
STUDENTS.Student_ID,
STUDENTS.FirstName,
STUDENTS.LastName,
COURSE.Course_name,
GRADES.MARKS
from STUDENTS
join REGISTRATION on STUDENTS.Student_ID = REGISTRATION.Student_ID
join COURSE on REGISTRATION.Course_ID =  COURSE.Course_ID
join GRADES on REGISTRATION.Registration_ID = GRADES.Registration_ID
where
GRADES.MARKS<50;

CREATE VIEW view_students_perfromance AS
select
STUDENTS.Student_ID,
STUDENTS.FirstName,
STUDENTS.LastName,
REGISTRATION.registration_ID AS registration_ID,
COURSE.Course_name,REGISTRATION.Academic_year,
REGISTRATION.semester,
GRADES.MARKS,
GRADES.Grade
FROM
STUDENTS
JOIN REGISTRATION ON STUDENTS.Student_ID = REGISTRATION.Student_ID
JOIN COURSE ON REGISTRATION.Course_ID = REGISTRATION.Course_ID
JOIN GRADES ON REGISTRATION.Registration_ID = GRADES.Registration_ID;

Select
COURSE.Course_ID,COURSE.Course_name,
count(REGISTRATION.Student_ID) AS total_REGISTRATION
from COURSE
JOIN REGISTRATION ON COURSE.Course_ID = REGISTRATION.Course_ID
GROUP BY COURSE.Course_ID, COURSE.Course_name
order by total_REGISTRATION desc;


