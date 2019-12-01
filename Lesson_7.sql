/*Тема “Сложные запросы”

Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/

SELECT users.id, users.name 
  FROM users
   LEFT OUTER JOIN orders
      ON users.id = orders.user_id
  WHERE orders.id IS NOT NULL
 GROUP BY users.name;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT products.id, products.name, catalogs.name 
  FROM products , catalogs
  WHERE products.catalog_id = catalogs.id;

-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(100) NOT NULL,
  `to` VARCHAR(100) NOT NULL
) COMMENT = 'Таблица рейсов';


DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(100) PRIMARY KEY,
  name VARCHAR(100) NOT NULL
) COMMENT = 'Таблица рейсов';

INSERT INTO cities
  (label, name)
VALUES
  ('Moscow', 'Москва'),
  ('Irkutsk', 'Иркутск'),
  ('Novgorod', 'Новгород'),
  ('Kazan', 'Казань'),
  ('Omsk', 'Омск');
 
ALTER TABLE flights
ADD CONSTRAINT fk_from
FOREIGN KEY (`from`)
REFERENCES cities (label)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE flights
ADD CONSTRAINT fk_to
FOREIGN KEY (`to`)
REFERENCES cities (label)
ON DELETE CASCADE
ON UPDATE CASCADE;

INSERT INTO flights
  (`from`, `to`)
VALUES
  ('Moscow', 'Omsk'),
  ('Novgorod', 'Kazan'),
  ('Irkutsk', 'Moscow'),
  ('Omsk', 'Irkutsk'),
  ('Moscow', 'Kazan');

SELECT C.name AS `from`, C1.name as `to`
FROM flights F
INNER JOIN cities C ON C.label = F.`from`
INNER JOIN cities C1 ON C1.label = F.`to`
ORDER BY F.id


