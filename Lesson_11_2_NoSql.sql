/*Практическое задание по теме “NoSQL”

1)В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
ip взят произвольный */

HSET key ip '192.168.32.35'
HSET key count 0 

/* 2)При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени. */

hset user_email name email
hset email_user email name

hget user_email "name" -- поиск почты
hget email_user "email" -- поиск имени


/*3) Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.*/
USE shop

db.products.insert({catalogs: 'Процессоры', name: 'Intel Core i3-8100', description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', price: 7890.00})
db.products.insert({catalogs: 'Процессоры', name: 'Intel Core i5-7400', description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', price: 12700.00})
db.products.insert({catalogs: 'Процессоры', name: 'AMD FX-8320E', description: 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', price: 4780.00})
db.products.insert({catalogs: 'Процессоры', name: 'AMD FX-8320', description: 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', price: 7120.00})
db.products.insert({catalogs: 'Материнские платы', name: 'ASUS ROG MAXIMUS X HERO', description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', price: 19310.00})
db.products.insert({catalogs: 'Материнские платы', name: 'Gigabyte H310M S2H', description: 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', price: 4790.00})
db.products.insert({catalogs: 'Материнские платы', name: 'MSI B250M GAMING PRO', description: 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', price: 5060.00})

db.products.insert({catalogs: 'Видеокарты'})
db.products.insert({catalogs: 'Жесткие диски'})
db.products.insert({catalogs: 'Оперативная память'})

-- или можно сначала создать категории с использованием внешнего индекса, а потом заполнять их (мне кажется где-то напутал)
USE shop;
db.catalogs.insertMany( [
      { _id: 1, name: "Процессоры"},
      { _id: 2, name: "Материнские платы"},
      { _id: 3 ,name: "Видеокарты"}
   ] );

db.products.insert({
    catalogs: 1,
    name: "Intel Core i3-8100",
    description: "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
    price: 7890.001
})


