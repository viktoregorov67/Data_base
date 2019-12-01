/*���� �������� ��������

��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.*/

SELECT users.id, users.name 
  FROM users
   LEFT OUTER JOIN orders
      ON users.id = orders.user_id
  WHERE orders.id IS NOT NULL
 GROUP BY users.name;

-- �������� ������ ������� products � �������� catalogs, ������� ������������� ������.

SELECT products.id, products.name, catalogs.name 
  FROM products , catalogs
  WHERE products.catalog_id = catalogs.id;

-- (�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). ���� from, to � label �������� ���������� �������� �������, ���� name � �������. �������� ������ ������ flights � �������� ���������� �������.

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(100) NOT NULL,
  `to` VARCHAR(100) NOT NULL
) COMMENT = '������� ������';


DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(100) PRIMARY KEY,
  name VARCHAR(100) NOT NULL
) COMMENT = '������� ������';

INSERT INTO cities
  (label, name)
VALUES
  ('Moscow', '������'),
  ('Irkutsk', '�������'),
  ('Novgorod', '��������'),
  ('Kazan', '������'),
  ('Omsk', '����');
 
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


