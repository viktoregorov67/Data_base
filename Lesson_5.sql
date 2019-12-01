-- Практическое задание к видеоуроку 5

-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

UPDATE users SET created_at=NOW(), updated_at=NOW();
 
-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения. 

UPDATE 
  users
SET 
  created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
  updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');


ALTER TABLE users MODIFY COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users MODIFY COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP;

-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей. 

SELECT * FROM storehouses_products ORDER BY IF(value > 0, 0, 1), value;

-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august') 

SELECT name FROM users WHERE date_format(birthday_at, '%M') IN ('may', 'august');

-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN. 

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2); 

-- Практическое задание теме “Агрегация данных” 
-- 1. Подсчитайте средний возраст пользователей в таблице users 

SELECT round(avg(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 1) AS middle_age FROM users;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения. 
/* Решал следующим способом:
1. Посчитал количество дней с начала года для даты рождения, получил число (dayofyear) 
2. Перевел полученное числовое значение в дату для текущего года (makedate)
3. Определил день недели полученной даты (DAYNAME)
4. Сгруппировал и отсортировал получившиеся значения
*/

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1987-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1991-08-29');
 
SELECT
  count(*) AS total,
  DAYNAME(
    makedate(2019, dayofyear(birthday_at))
  ) as day_name
FROM 
  users
GROUP BY 
  day_name
ORDER BY
  total DESC;
 

-- 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы 
 
 DROP TABLE IF EXISTS tab;
CREATE TABLE tab (
  value BIGINT
  )

INSERT INTO tab(value) VALUES (1), (2), (3), (4), (5);
  
SELECT round(exp(sum(ln(value)))) FROM tab;

