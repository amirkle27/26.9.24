--1
drop function sp_add_students_with_new_grade;
CREATE or replace function sp_add_students_with_new_grade()
    RETURNS TRIGGER AS $$
        BEGIN
            UPDATE courses
                SET total_num_of_students =
                    (SELECT COUNT(DISTINCT student_id)
                    FROM grades
                    WHERE course_id = NEW.course_id)
                WHERE course_id = NEW.course_id;

            RETURN NEW;
        END
    $$ language plpgsql;


CREATE TRIGGER add_students_with_new_grade
AFTER INSERT ON grades
FOR EACH ROW
EXECUTE FUNCTION sp_add_students_with_new_grade();

SELECT c.*, g.*
FROM courses c
JOIN grades g
ON c.course_id = g.course_id;

INSERT INTO grades (student_id, course_id, grade) VALUES (1,2,88);

SELECT * FROM courses WHERE course_id = 2;




drop function sp_add_students_with_new_grade;
CREATE or replace function sp_add_students_with_new_grade()
    RETURNS TRIGGER AS $$
        BEGIN
            UPDATE courses
                SET total_num_of_students =
                    (SELECT COUNT(DISTINCT student_id)
                    FROM grades
                    WHERE course_id = NEW.course_id)
                WHERE course_id = NEW.course_id;
            RETURN NEW;
        END
    $$ language plpgsql;

drop function sp_deduct_students_with_deleted_grade;
CREATE OR REPLACE FUNCTION sp_deduct_students_with_deleted_grade()
    RETURNS TRIGGER AS $$
        BEGIN
            UPDATE courses
                SET total_num_of_students =
                    (SELECT COUNT(DISTINCT student_id)
                     FROM grades
                     WHERE course_id = OLD.course_id)
                WHERE course_id = OLD.course_id;
            RETURN OLD;
        END
    $$ language plpgsql;


CREATE TRIGGER deduct_students_with_deleted_grade
AFTER DELETE ON grades
FOR EACH ROW
EXECUTE FUNCTION sp_deduct_students_with_deleted_grade();

DELETE FROM grades
WHERE student_id = 1
AND course_id = 2;

SELECT * FROM courses WHERE course_id = 2;

--2
CREATE VIEW grades_students_courses AS
    SELECT
        s.name,
        c.course_name,
        g.grade
    FROM courses c
    JOIN grades g
    ON c.course_id = g.course_id
    JOIN students s
    ON g.student_id = s.student_id;

select * from grades_students_courses;

CREATE VIEW grades_above_80 AS
    SELECT
        s.name,
        c.course_name,
        g.grade
    FROM courses c
    JOIN grades g
    ON c.course_id = g.course_id
    JOIN students s
    ON g.student_id = s.student_id
    WHERE g.grade > 80;

select * from grades_above_80;

CREATE VIEW course_with_most_students AS
    SELECT course_name, total_num_of_students
    FROM courses
    WHERE total_num_of_students = (SELECT MAX(total_num_of_students) FROM courses)

select * from course_with_most_students;

--3
drop function sp_student_with_highest_grade;

CREATE or replace function sp_student_with_highest_grade()
    RETURNS TABLE(student_name VARCHAR,course VARCHAR, highest_grade REAL) AS $$
        BEGIN
            RETURN QUERY
            SELECT s.name student_name, c.course_name course, g.grade highest_grade
            FROM students s
            JOIN grades g
            ON s.student_id = g.student_id
            JOIN courses c
            ON g.course_id = c.course_id
            WHERE g.grade = (SELECT MAX(grade) FROM grades);
        END;
    $$ language plpgsql;

select * from sp_student_with_highest_grade()
