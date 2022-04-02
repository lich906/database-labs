#3.1 ---INSERT---
#3.1a Без указания списка полей

INSERT INTO film
VALUES (DEFAULT, 1, 'Matrix', 'The Matrix movie. Post apocalypse, cyberpunk.', 145, 23, 83000000, 183),
       (DEFAULT, 1, 'Forrest Gump',
        'Forrest Gump is a 1994 American comedy-drama film directed by Robert Zemeckis and written by Eric Roth.', 256,
        43, 55000000, 142),
       (DEFAULT, 2, 'Terminator', 'Cyborg invasion comes true story', 276, 12, 120000000, 160),
       (DEFAULT, 3, 'Lord of the Ring',
        'The Lord of the Rings: The Fellowship of the Ring has beautiful visuals, ambitious story, great characters, heart and is brooding as well.',
        780, 134, 100000000, 179),
       (DEFAULT, 3, 'Star Wars',
        'Every once in a while I have what I think of as an out-of-the-body experience at a movie. When the ESP people use a phrase like that, they''re referring to the sensation of the mind actually leaving the body and spiriting itself off to China or Peoria or a galaxy far, far away.',
        567, 23, 45000000, 156);

INSERT INTO country
VALUES (DEFAULT, 'USA', '/images/us-flag.svg'),
       (DEFAULT, 'Russia', '/images/ru-flag.svg'),
       (DEFAULT, 'Germany', '/images/de-flag.svg'),
       (DEFAULT, 'Brazil', '/images/br-flag.svg'),
       (DEFAULT, 'India', NULL),
       (DEFAULT, 'Sweden', NULL);

INSERT INTO premiere
VALUES (DEFAULT, 2, 3, '1989-11-12'),
       (DEFAULT, 1, 3, '2004-09-22'),
       (DEFAULT, 2, 4, '2012-03-08'),
       (DEFAULT, 2, 5, '1999-12-01'),
       (DEFAULT, 3, 1, '2014-07-12'),
       (DEFAULT, 3, 4, '1970-03-31');

INSERT INTO actor
VALUES (DEFAULT, 'Keanu', 'Revees', '1981-08-14', DEFAULT, NULL),
       (DEFAULT, 'Vasya', 'Pupkin', '1998-04-02', 123,
        'Vasya Pupkin was born in Russia 1998 April. Famous artist of modern russian movies'),
       (DEFAULT, 'Arnold', 'Schwarzenegger', '1965-06-29', 431, NULL),
       (DEFAULT, 'Maria', 'Palmer', '1970-12-22', 231, 'Some description about actress. ');

INSERT INTO box_office
VALUES (DEFAULT, 2, 3, 1, 500000),
       (DEFAULT, 1, 3, 2, 10500000),
       (DEFAULT, 2, 4, 3, 100000),
       (DEFAULT, 2, 5, 4, 5000);

INSERT INTO role
VALUES (DEFAULT, 1, 1, 1, 120000, 'Neo', 'The cosen one'),
       (DEFAULT, 3, 2, 3, 135000, 'Sarah Connor', 'Mother of leader of mankind'),
       (DEFAULT, 2, 3, 1, 201000, 'Anakin Skywalker', 'Powerful jedi and father of Luke');

#3.1b С указанием списка полей
INSERT INTO film_company (id_country, name, description, rating, lead_producer_name)
VALUES (1, 'Warner Bros', 'Warner Bros company description', 7434, 'Fearling Friz'),
       (2, 'Columbia Pictures', 'Columbia Pictures company description', 2356, 'Garry Conn');

#3.1c С чтением значения из другой таблицы
TRUNCATE TABLE film_backup;
INSERT INTO film_backup (id_film_company, name, short_description, budget, running_time)
SELECT id_film_company,
       name,
       short_description,
       budget,
       running_time
FROM film;

#3.2 ---DELETE---
#3.2a Все записи
DELETE
FROM film_company;

#3.2b
DELETE
FROM film f
WHERE f.short_description IS NULL;

#3.3 ---UPDATE---
#3.3a Все записи
UPDATE
    film f
SET f.likes_count    = 0,
    f.dislikes_count = 0;

#3.3b По условию обновляя один атрибут
UPDATE
    film f
SET f.dislikes_count = 0
WHERE f.likes_count = 0;

#3.3c По условию обновляя несколько атрибутов
UPDATE
    actor a
SET a.rating = 0,
    a.birth  = NULL
WHERE a.biography IS NULL;

#3.4 ---SELECT---
#3.4a С набором извлекаемых атрибутов
SELECT c.name,
       c.flag_image_path
FROM country c;

#3.4b Со всеми атрибутами
SELECT *
FROM film_company;

#3.4c С условием по атрибуту
SELECT *
FROM premiere p
WHERE p.id_country = 3;

#3.5 ---SELECT ORDER BY + TOP(LIMIT)
#3.5a С сортировкой по возрастанию ASC + ограничение вывода кол-ва записей
SELECT f.name,
       f.budget,
       f.running_time,
       f.dislikes_count
FROM film f
ORDER BY f.dislikes_count
LIMIT 100;

#3.5b С сортировкой по убыванию
SELECT f.name,
       f.budget,
       f.running_time,
       f.likes_count
FROM film f
ORDER BY f.likes_count DESC;

#3.5c С сортировкой по двум атрибутам + ограничение вывода кол-ва записей
SELECT f.name,
       f.budget,
       f.running_time,
       f.likes_count
FROM film f
ORDER BY f.budget DESC,
         f.likes_count DESC
LIMIT 500;

#3.5d С сортировкой по первому атрибуту из списка извлекаемых
SELECT f.name,
       f.budget
FROM film f
ORDER BY 1;

#3.6 ---Работа с датами---
#3.6a WHERE по дате
SELECT *
FROM premiere p
WHERE p.date > CURRENT_DATE;

#3.6b WHERE дата в диапазоне
SELECT *
FROM premiere p
WHERE p.date BETWEEN '2000-01-01' AND '2000-12-31';

#3.6c Извлечь только год
SELECT YEAR(p.date) year
FROM premiere p
WHERE p.id_premiere = 123;

#3.7 ---Функции агрегации---
#3.7a Посчитать количество записей в таблице
SELECT COUNT(*)
FROM country;

#3.7b Посчитать количество уникальных записей в таблице
SELECT COUNT(DISTINCT f.name)
FROM film f;

#3.7c Вывести уникальные значения столбца
SELECT DISTINCT r.id_actor
FROM role r;

#3.7d Найти максимальное значение столбца
SELECT MAX(f.running_time)
FROM film f;

#3.7e Найти минимальное значение столбца
SELECT MIN(f.running_time)
FROM film f;

#3.7f COUNT() + GROUP BY
SELECT COUNT(id_premiere),
       p.id_country
FROM premiere p
GROUP BY p.id_country;

#3.8 ---SELECT GROUP BY + HAVING---
# Извлекает кол-во премьер за все время по странам, в которых было более 20 премьер
SELECT p.id_country,
       COUNT(p.id_premiere) premiere_count_by_country
FROM premiere p
GROUP BY p.id_country
HAVING premiere_count_by_country > 20;

# Извлекает сумму гонораров актерам каждого фильма, где сумма превышает 100000
SELECT r.id_film,
       SUM(r.fee) total_fee_by_film
FROM role r
GROUP BY r.id_film
HAVING total_fee_by_film > 100000;

# Извлекает максимальное кол-во кассовых сборов на один фильм в каждой стране превышающие 100000
SELECT bo.id_country,
       MAX(bo.value) max_box_office_by_country
FROM box_office bo
GROUP BY bo.id_country
HAVING max_box_office_by_country > 100000;

#3.9 SELECT JOIN
SELECT r.fee,
       f.name
FROM role r
         LEFT JOIN film f ON r.id_film = f.id_film
WHERE r.is_main_role IS TRUE;

SELECT r.fee,
       f.name
FROM film f
         RIGHT JOIN role r ON r.id_film = f.id_film
WHERE r.is_main_role IS TRUE;

SELECT r.fee,
       f.name,
       fc.name,
       a.first_name,
       a.second_name
FROM role r
         LEFT JOIN film f ON r.id_film = f.id_film
         LEFT JOIN actor a ON r.id_actor = a.id_actor
         LEFT JOIN film_company fc ON f.id_film_company = fc.id_film_company
WHERE f.budget < 1000000
  AND r.fee < 5000
  AND a.rating < 200;

SELECT r.character_name,
       a.first_name,
       a.second_name
FROM role r
         INNER JOIN actor a ON r.id_actor = a.id_actor;

#3.10 ---Подзапросы---
SELECT r.*
FROM role r
WHERE r.id_film IN (SELECT f.id_film FROM film f WHERE f.running_time > 210);

SELECT f.id_film                                                                     id,
       f.name,
       (SELECT r.character_name FROM role r WHERE r.id_film = id AND r.id_actor = 2) actors_character_name
FROM film f;

SELECT nested_table.*
FROM (SELECT f.name, f.budget FROM film f WHERE f.budget BETWEEN 100000 AND 200000) nested_table
WHERE nested_table.name LIKE '%ring%';

SELECT bo.id_box_office,
       bo.value
FROM box_office bo
         LEFT JOIN
     (SELECT c.id_country FROM country c WHERE c.flag_image_path IS NOT NULL) countiry_flag_not_null
     ON bo.id_country = countiry_flag_not_null.id_country;
