﻿/*Практическое задание по теме “Оптимизация запросов”

Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.*/

CREATE TABLE logs (
  table_name VARCHAR(20) NOT NULL,
  pk_id INT UNSIGNED NOT NULL,
  name VARCHAR(255),
  created_at DATETIME DEFAULT NOW()
) ENGINE=ARCHIVE;

CREATE TRIGGER users_log AFTER INSERT ON users FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'users',
      pk_id = NEW.id,
      name = NEW.name;

CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'catalogs',
      pk_id = NEW.id,
      name = NEW.name;

CREATE TRIGGER products_log AFTER INSERT ON products FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'products',
      pk_id = NEW.id,
      name = NEW.name;


/*2) (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.*/

USE shop;

DELIMITER $$

DROP PROCEDURE IF EXISTS test$$
CREATE PROCEDURE test()
BEGIN
   DECLARE count INT DEFAULT 0;
   WHILE count < 1000 DO
      INSERT INTO users (name, birthday_at) VALUES
        (LEFT(UUID(), RAND()*(10-5)+5), DATE(CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 365) DAY)),
      SET count = count + 1;
   END WHILE;
END$$
DELIMITER;

test();


