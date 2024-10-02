
--------------------------------- Create tables

-- Students table with course_avg_grades and num_courses dynamically updated
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    course_avg_grades REAL DEFAULT 0,  -- Will be dynamically updated with triggers
    num_courses INT DEFAULT 0          -- Will be dynamically updated with triggers
);

-- Courses table with total_num_of_students dynamically updated
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    total_num_of_students INT DEFAULT 0  -- Will be dynamically updated with triggers
);

-- Grades table with a composite primary key of student_id and course_id
CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade REAL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert 30 students
INSERT INTO students (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com'),
('David', 'david@example.com'),
('Eve', 'eve@example.com'),
('Frank', 'frank@example.com'),
('Grace', 'grace@example.com'),
('Hank', 'hank@example.com'),
('Ivy', 'ivy@example.com'),
('Jack', 'jack@example.com'),
('Kevin', 'kevin@example.com'),
('Laura', 'laura@example.com'),
('Michael', 'michael@example.com'),
('Nancy', 'nancy@example.com'),
('Oscar', 'oscar@example.com'),
('Pam', 'pam@example.com'),
('Quinn', 'quinn@example.com'),
('Rick', 'rick@example.com'),
('Steve', 'steve@example.com'),
('Tina', 'tina@example.com'),
('Uma', 'uma@example.com'),
('Victor', 'victor@example.com'),
('Wendy', 'wendy@example.com'),
('Xander', 'xander@example.com'),
('Yvonne', 'yvonne@example.com'),
('Zach', 'zach@example.com'),
('Amber', 'amber@example.com'),
('Bruce', 'bruce@example.com'),
('Clara', 'clara@example.com');

-- Insert 8 courses
INSERT INTO courses (course_name) VALUES
('Mathematics'),
('Physics'),
('Chemistry'),
('Biology'),
('History'),
('Geography'),
('Literature'),
('Computer Science');

