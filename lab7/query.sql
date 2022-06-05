#1. Добавить внешние ключи
ALTER TABLE lesson
    ADD CONSTRAINT lesson_teacher_id_teacher_fk
        FOREIGN KEY (id_teacher) REFERENCES teacher (id_teacher),

    ADD CONSTRAINT lesson_group_id_group_fk
        FOREIGN KEY (id_group) REFERENCES `group` (id_group),

    ADD CONSTRAINT lesson_subject_id_subject_fk
        FOREIGN KEY (id_subject) REFERENCES subject (id_subject);

ALTER TABLE student
    ADD CONSTRAINT student_group_id_group_fk
        FOREIGN KEY (id_group) REFERENCES `group` (id_group);

ALTER TABLE mark
    ADD CONSTRAINT mark_lesson_id_lesson_fk
        FOREIGN KEY (id_lesson) REFERENCES lesson (id_lesson),

    ADD CONSTRAINT mark_student_id_student_fk
        FOREIGN KEY (id_student) REFERENCES student (id_student);

#2. Выдать оценки студентов по информатике если они обучаются данному предмету.
#   Оформить выдачу данных с использованием view.
DROP VIEW IF EXISTS informatics_results;
CREATE VIEW informatics_results AS
SELECT st.*, m.mark
FROM mark m
LEFT JOIN lesson l ON l.id_lesson = m.id_lesson
LEFT JOIN student st ON st.id_student = m.id_student
LEFT JOIN subject s ON l.id_subject = s.id_subject
WHERE s.name = 'Информатика';

SELECT *
FROM informatics_results;

#3. Дать информацию о должниках с указанием фамилии студента и названия предмета.
#   Должниками считаются студенты, не имеющие оценки по предмету, который ведется в группе.
#   Оформить в виде процедуры, на входе идентификатор группы.
DROP PROCEDURE IF EXISTS get_debtors_by_group_id;
CREATE PROCEDURE get_debtors_by_group_id(IN group_id INT)
BEGIN
    SELECT DISTINCT st.name, s.name
    FROM student st
    LEFT JOIN lesson l
        ON st.id_group = l.id_group AND
           l.id_lesson NOT IN (SELECT DISTINCT m.id_lesson FROM mark m WHERE m.id_student = st.id_student)
    LEFT JOIN subject s ON l.id_subject = s.id_subject
    WHERE st.id_student IN (SELECT s.id_student FROM student s WHERE s.id_group = group_id);
END;

CALL get_debtors_by_group_id(4);

#4. Дать среднюю оценку студентов по каждому предмету для тех предметов, по которым занимается не менее 35 студентов.
DROP TEMPORARY TABLE IF EXISTS subject_over_35_pupils;
CREATE TEMPORARY TABLE subject_over_35_pupils
SELECT s.id_subject
FROM `group` g
INNER JOIN lesson l ON g.id_group = l.id_group
INNER JOIN subject s ON l.id_subject = s.id_subject
INNER JOIN student st ON g.id_group = st.id_group
GROUP BY s.name
HAVING COUNT(DISTINCT st.id_student) > 35;

SELECT st.name, s.name, students_avg_marks.average_mark
FROM (
         SELECT st.id_student, l.id_subject, AVG(m.mark) average_mark
         FROM mark m
         LEFT JOIN student st ON st.id_student = m.id_student
         LEFT JOIN lesson l ON l.id_lesson = m.id_lesson
         INNER JOIN subject_over_35_pupils so35p ON l.id_subject = so35p.id_subject
         GROUP BY m.id_student, l.id_subject
     ) students_avg_marks
LEFT JOIN student st ON students_avg_marks.id_student = st.id_student
LEFT JOIN subject s ON students_avg_marks.id_subject = s.id_subject;

#5. Дать оценки студентов специальности ВМ по всем проводимым предметам с указанием группы, фамилии, предмета, даты.
#   При отсутствии оценки заполнить значениями NULL поля оценки
SELECT g.name, st.name, s.name, l.date, m.mark
FROM `group` g
INNER JOIN student st ON g.id_group = st.id_group
INNER JOIN lesson l ON g.id_group = l.id_group
INNER JOIN subject s ON l.id_subject = s.id_subject
LEFT JOIN mark m ON l.id_lesson = m.id_lesson AND st.id_student = m.id_student
WHERE g.name = 'ВМ';

#6. Всем студентам специальности ПС, получившим оценки меньшие 5 по предмету БД до 12.05, повысить эти оценки на 1 балл.
START TRANSACTION;
UPDATE mark m
INNER JOIN lesson l ON l.id_lesson = m.id_lesson AND l.date < '2019-05-12'
INNER JOIN `group` g ON g.id_group = l.id_group AND g.name = 'ПС'
INNER JOIN subject s ON s.id_subject = l.id_subject AND s.name = 'БД'
SET m.mark = m.mark + 1
WHERE m.mark < 5;
ROLLBACK;

#7. Добавить необходимые индексы.
#CREATE INDEX IX_mark_id_student
#    ON mark (id_student);

#CREATE INDEX IX_mark_id_lesson
#    ON mark (id_lesson);

CREATE INDEX IX_mark_id_student_id_lesson
    ON mark(id_student, id_lesson);

CREATE INDEX IX_lesson_id_subject
    ON lesson (id_subject);

CREATE INDEX IX_lesson_id_group
    ON lesson (id_group);

CREATE INDEX IX_student_id_group
    ON student (id_group);