CREATE TABLE Film (
    film_id INT PRIMARY KEY,
    title VARCHAR(100),
    director VARCHAR(50),
    release_year INT,
    genre VARCHAR(50),
    rating DECIMAL(3,1)
);

INSERT INTO Film (film_id, title, director, release_year, genre, rating) VALUES
(1, 'Inception', 'Christopher Nolan', 2010, 'Sci-Fi', 8.8),
(2, 'The Godfather', 'Francis Ford Coppola', 1972, 'Crime', 9.2),
(3, 'The Dark Knight', 'Christopher Nolan', 2008, 'Action', 9.0),
(4, 'Pulp Fiction', 'Quentin Tarantino', 1994, 'Crime', 8.9),
(5, 'Forrest Gump', 'Robert Zemeckis', 1994, 'Drama', 8.8),
(6, 'Interstellar', 'Christopher Nolan', 2014, 'Sci-Fi', 8.6),
(7, 'Gladiator', 'Ridley Scott', 2000, 'Action', 8.5),
(8, 'The Matrix', 'Lana Wachowski', 1999, 'Sci-Fi', 8.7),
(9, 'Fight Club', 'David Fincher', 1999, 'Drama', 8.8),
(10, 'The Shawshank Redemption', 'Frank Darabont', 1994, 'Drama', 9.3);
-- AGGREGATE FUNTIONS:
SELECT AVG(RATING) FROM FILM; -- AVERAGE RATING OF FILMS
SELECT COUNT(*) FROM FILM;-- NO OF RECORDS
SELECT MAX(RATING) FROM FILM; -- HIGHEST RATING
SELECT MIN(RATING) FROM FILM; -- LOWEST RATING

CREATE TABLE Salaries (
    emp_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);
INSERT INTO Salaries (emp_id, employee_name, department, salary) VALUES
(1, 'Ali Khan', 'IT', 60000),
(2, 'Sara Ahmed', 'HR', 50000),
(3, 'Usman Raza', 'Finance', 70000),
(4, 'Ayesha Iqbal', 'IT', 65000),
(5, 'Hamza Malik', 'Marketing', 55000),
(6, 'Hina Shah', 'HR', 52000),
(7, 'Bilal Tariq', 'IT', 63000),
(8, 'Zara Ali', 'Finance', 71000),
(9, 'Noor Hassan', 'Marketing', 58000),
(10, 'Omar Siddiqui', 'IT', 64000);
SELECT DEPARTMENT, SUM(SALARY) FROM SALARIES GROUP BY DEPARTMENT ORDER BY DEPARTMENT ASC; 
SELECT STRING_AGG(EMPLOYEE_NAME,',') AS ALL_EMPLOYEES FROM SALARIES; 
SELECT DEPARTMENT,STRING_AGG(EMPLOYEE_NAME,',' ORDER BY EMPLOYEE_NAME ASC) FROM SALARIES GROUP BY DEPARTMENT;
-- SUB QUERIES:
SELECT EMP_ID,EMPLOYEE_NAME,SALARY FROM SALARIES WHERE SALARY=(SELECT MAX(SALARY) FROM SALARIES);
SELECT EMP_ID,EMPLOYEE_NAME,SALARY FROM SALARIES WHERE DEPARTMENT=(SELECT DEPARTMENT FROM SALARIES WHERE EMPLOYEE_NAME='Zara Ali');

-- LAB-05 TASKS:
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(10) NOT NULL,
    marks INT NOT NULL CHECK (marks BETWEEN 0 AND 100)
);

INSERT INTO students (name, department, marks) VALUES
('Ali', 'CS', 95),
('Sara', 'IT', 85),
('Ahmed', 'EE', 92),
('Zain', 'CS', 78),
('Fatima', 'IT', 88),
('Bilal', 'EE', 80);
SELECT * FROM STUDENTS WHERE MARKS>(SELECT AVG(MARKS) FROM STUDENTS);
SELECT * FROM STUDENTS WHERE MARKS ANY (SELECT MARKS FROM STUDENTS);
SELECT * FROM STUDENTS WHERE MARKS>ANY(SELECT MARKS FROM STUDENTS WHERE DEPARTMENT='CS');
SELECT * FROM STUDENTS WHERE MARKS>90;

CREATE TABLE courses_completed (
    record_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    course_count INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO courses_completed (student_id, course_count) VALUES
(1, 5),
(2, 6),
(3, 4),
(4, 5),
(5, 3),
(6, 7);

SELECT *FROM COURSES_COMPLETED WHERE COURSE_COUNT>(SELECT AVG(COURSE_COUNT) FROM COURSES_COMPLETED);
SELECT *FROM STUDENTS WHERE MARKS > ALL(SELECT MARKS FROM STUDENTS WHERE DEPARTMENT='IT');
SELECT *FROM COURSES_COMPLETED WHERE EXISTS(SELECT *FROM COURSES_COMPLETED WHERE COURSE_COUNT>=1);
SELECT *FROM STUDENTS WHERE MARKS=(SELECT MAX(MARKS) FROM STUDENTS WHERE MARKS<(SELECT MAX(MARKS) FROM STUDENTS));


CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(10) NOT NULL CHECK (department IN ('CS','IT','EE','ME')),
    gpa DECIMAL(3,2) NOT NULL CHECK (gpa BETWEEN 0 AND 4)
);

INSERT INTO students (name, department, gpa) VALUES
('Ali', 'CS', 3.8),
('Sara', 'IT', 3.5),
('Ahmed', 'EE', 3.9),
('Zain', 'CS', 3.2),
('Fatima', 'IT', 3.6),
('Bilal', 'EE', 3.7);
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    department VARCHAR(10) NOT NULL CHECK (department IN ('CS','IT','EE','ME'))
);

INSERT INTO courses (course_name, credits, department) VALUES
('Database Systems', 3, 'CS'),
('Operating Systems', 4, 'CS'),
('Network Security', 3, 'IT'),
('Machine Learning', 3, 'CS'),
('Digital Circuits', 3, 'EE'),
('Microprocessors', 4, 'EE');
CREATE TABLE enrollments (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
INSERT INTO enrollments (student_id, course_id) VALUES
(1, 1),  -- Ali enrolled in Database Systems
(1, 2),  -- Ali in Operating Systems
(2, 3),  -- Sara in Network Security
(2, 4),  -- Sara in Machine Learning
(3, 5),  -- Ahmed in Digital Circuits
(3, 6),  -- Ahmed in Microprocessors
(4, 1),  -- Zain in Database Systems
(5, 3),  -- Fatima in Network Security
(6, 5);  -- Bilal in Digital Circuits
SELECT COUNT(*) FROM STUDENTS;
SELECT S.STUDENT_ID,S.NAME,(SELECT COUNT(*) FROM ENROLLMENTS E WHERE E.STUDENT_ID=S.STUDENT_ID) FROM STUDENTS S;




SELECT S.NAME,(SELECT COUNT(*) FROM ENROLLMENTS E WHERE E.STUDENT_ID=S.STUDENT_ID) FROM STUDENTS S;
SELECT C.COURSE_NAME,(SELECT COUNT(*) FROM ENROLLMENTS E WHERE E.COURSE_ID=C.COURSE_ID) FROM COURSES C;
SELECT C.COURSE_NAME,











