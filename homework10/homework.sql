-- 1 Задание 
mysql root@localhost:vk> use shop
You are now connected to database "shop" as user "root"
Time: 0.002s
mysql root@localhost:shop> CREATE TABLE Logs (
                        ->     id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        ->     created_at datetime DEFAULT CURRENT_TIMESTAMP,
                        ->     table_name varchar(50) NOT NULL,
                        ->     row_id INT UNSIGNED NOT NULL,
                        ->     row_name varchar(255)
                        -> ) ENGINE = Archive;
Query OK, 0 rows affected
Time: 0.016s
mysql root@localhost:shop> CREATE TRIGGER products_insert AFTER INSERT ON products
                        -> FOR EACH ROW
                        -> BEGIN
                        ->     INSERT INTO Logs VALUES (NULL, DEFAULT, "products", NEW.id, NEW.name);
                        -> END;
Query OK, 0 rows affected
Time: 0.023s
mysql root@localhost:shop> CREATE TRIGGER users_insert AFTER INSERT ON users
                        -> FOR EACH ROW
                        -> BEGIN
                        ->     INSERT INTO Logs VALUES (NULL, DEFAULT, "users", NEW.id, NEW.name);
                        -> END;
                        -> 
Query OK, 0 rows affected
Time: 0.019s
mysql root@localhost:shop> 
                        -> CREATE TRIGGER catalogs_insert AFTER INSERT ON catalogs
                        -> FOR EACH ROW
                        -> BEGIN
                        ->     INSERT INTO Logs VALUES (NULL, DEFAULT, "catalogs", NEW.id, NEW.name);
                        -> END;
Query OK, 0 rows affected
Time: 0.020s
mysql root@localhost:shop> select * from catalogs;
+------+--------------------+
|   id | name               |
|------+--------------------|
|    1 | Процессоры         |
|    2 | Материнские платы  |
|    3 | Видеокарты         |
|    4 | Жесткие диски      |
|    5 | Оперативная память |
+------+--------------------+
5 rows in set
Time: 0.003s
mysql root@localhost:shop> SELECT * from products;
+------+-------------------------+-----------------------------------------------------------------------------------+---------+--------------+---------------------+---------------------+
|   id | name                    | description                                                                       |   price |   catalog_id | created_at          | updated_at          |
|------+-------------------------+-----------------------------------------------------------------------------------+---------+--------------+---------------------+---------------------|
|    1 | Intel Core i3-8100      | Процессор для настольных персональных компьютеров, основанных на платформе Intel. |    7890 |            1 | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    2 | Intel Core i5-7400      | Процессор для настольных персональных компьютеров, основанных на платформе Intel. |   12700 |            1 | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    3 | AMD FX-8320E            | Процессор для настольных персональных компьютеров, основанных на платформе AMD.   |    4780 |            1 | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    4 | AMD FX-8320             | Процессор для настольных персональных компьютеров, основанных на платформе AMD.   |    7120 |            1 | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    5 | ASUS ROG MAXIMUS X HERO | Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX        |   19310 |            2 | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    6 | Gigabyte H310M S2H      | Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX            |    4790 |            2 | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    7 | MSI B250M GAMING PRO    | Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX             |    5060 |            2 | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
+------+-------------------------+-----------------------------------------------------------------------------------+---------+--------------+---------------------+---------------------+
7 rows in set
Time: 0.004s
mysql root@localhost:shop> INSERT INTO products VALUES (NULL, 'some new', 'djaslkjdlsa', 1000, 1 , NULL , NULL)
Query OK, 1 row affected
Time: 0.013s
mysql root@localhost:shop> select * from Logs;
+------+---------------------+--------------+----------+------------+
|   id | created_at          | table_name   |   row_id | row_name   |
|------+---------------------+--------------+----------+------------|
|    1 | 2020-04-08 16:49:19 | products     |        8 | some new   |
+------+---------------------+--------------+----------+------------+
1 row in set
Time: 0.009s
mysql root@localhost:shop> 


-- 2. Задание
mysql root@localhost:shop> CREATE TABLE samples (
                        ->   id SERIAL PRIMARY KEY,
                        ->   name VARCHAR(255) COMMENT 'Имя покупателя',
                        ->   birthday_at DATE COMMENT 'Дата рождения',
                        ->   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                        ->   updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
                        -> ) COMMENT = 'Покупатели';
Query OK, 0 rows affected
Time: 0.075s
mysql root@localhost:shop> INSERT INTO samples (name, birthday_at) VALUES
                        ->   ('Геннадий', '1990-10-05'),
                        ->   ('Наталья', '1984-11-12'),
                        ->   ('Александр', '1985-05-20'),
                        ->   ('Сергей', '1988-02-14'),
                        ->   ('Иван', '1998-01-12'),
                        ->   ('Мария', '1992-08-29'),
                        ->   ('Аркадий', '1994-03-17'),
                        ->   ('Ольга', '1981-07-10'),
                        ->   ('Владимир', '1988-06-12'),
                        ->   ('Екатерина', '1992-09-20');
                        -> 
Query OK, 10 rows affected
Time: 0.018s
mysql root@localhost:shop> SELECT
                        ->   COUNT(*)
                        -> FROM
                        ->   samples AS fst,
                        ->   samples AS snd,
                        ->   samples AS thd,
                        ->   samples AS fth,
                        ->   samples AS fif,
                        ->   samples AS sth;
+------------+
|   COUNT(*) |
|------------|
|    1000000 |
+------------+
1 row in set
Time: 0.004s
mysql root@localhost:shop> 
                        -> SELECT COUNT(*) FROM users;
+------------+
|   COUNT(*) |
|------------|
|          6 |
+------------+
1 row in set
Time: 0.005s
mysql root@localhost:shop> SELECT * FROM users LIMIT 10;
+------+-----------+---------------+---------------------+---------------------+
|   id | name      | birthday_at   | created_at          | updated_at          |
|------+-----------+---------------+---------------------+---------------------|
|    1 | Геннадий  | 1990-10-05    | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    2 | Наталья   | 1984-11-12    | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    3 | Александр | 1985-05-20    | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    4 | Сергей    | 1988-02-14    | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    5 | Иван      | 1998-01-12    | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
|    6 | Мария     | 1992-08-29    | 2020-02-15 18:01:07 | 2020-02-15 18:01:07 |
+------+-----------+---------------+---------------------+---------------------+
6 rows in set
Time: 0.004s
mysql root@localhost:shop> 

-- 3 задание

svetlana@svetlana-VirtualBox:~$ redis-cli 
127.0.0.1:6379> HINCRBY addr '10.10.10.10' 1
(integer) 1
127.0.0.1:6379> HINCRBY addr '10.10.10.11' 2
(integer) 2
127.0.0.1:6379> HGETALL addr
1) "10.10.10.10"
2) "1"
3) "10.10.10.11"
4) "2"
127.0.0.1:6379> HGET addr 1
(nil)
127.0.0.1:6379> HGET addr 2
(nil)
127.0.0.1:6379> HGET addr '10.10.10.10'
"1"
127.0.0.1:6379> HGET addr '10.10.10.11'
"2"

-- 4 задание

127.0.0.1:6379> HSET emails 'some1' 'some1@ya.ru'
(integer) 1
127.0.0.1:6379> HSET emails 'some2' 'some2@ya.ru'
(integer) 1
127.0.0.1:6379> HSET emails 'some3' 'some3@ya.ru'
(integer) 1
127.0.0.1:6379> HGET emails 'some2'
"some2@ya.ru"
127.0.0.1:6379> HSET users 'some3@ya.ru' 'some3'
(integer) 1
127.0.0.1:6379> HSET users 'some1@ya.ru' 'some1'
(integer) 1
127.0.0.1:6379> HSET users 'some2@ya.ru' 'some2'
(integer) 1
127.0.0.1:6379> HGET users 'some1@ya.ru'
"some1"
127.0.0.1:6379> 

-- 5 задание

> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB
> 
> use shop
switched to db shop
> 
> db.createCollection('catalogs')
{ "ok" : 1 }
> db.createCollection('products')
{ "ok" : 1 }
> 
> db.catalogs.insert({name: 'Процессоры'})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert({name: 'Мат.платы'})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert({name: 'Видеокарты'})
WriteResult({ "nInserted" : 1 })
> db.catalogs.
db.catalogs.addIdIfNeeded(              db.catalogs.drop(                       db.catalogs.getFullName(                db.catalogs.group(                      db.catalogs.prototype                   db.catalogs.tojson(
db.catalogs.aggregate(                  db.catalogs.dropIndex(                  db.catalogs.getIndexKeys(               db.catalogs.groupcmd(                   db.catalogs.reIndex(                    db.catalogs.totalIndexSize(
db.catalogs.bulkWrite(                  db.catalogs.dropIndexes(                db.catalogs.getIndexSpecs(              db.catalogs.hasOwnProperty              db.catalogs.remove(                     db.catalogs.totalSize(
db.catalogs.constructor                 db.catalogs.ensureIndex(                db.catalogs.getIndexes(                 db.catalogs.hashAllDocs(                db.catalogs.renameCollection(           db.catalogs.unsetWriteConcern(
db.catalogs.convertToCapped(            db.catalogs.exists(                     db.catalogs.getIndices(                 db.catalogs.help(                       db.catalogs.replaceOne(                 db.catalogs.update(
db.catalogs.convertToSingleObject(      db.catalogs.explain(                    db.catalogs.getMongo(                   db.catalogs.initializeOrderedBulkOp(    db.catalogs.runCommand(                 db.catalogs.updateMany(
db.catalogs.copyTo(                     db.catalogs.find(                       db.catalogs.getName(                    db.catalogs.initializeUnorderedBulkOp(  db.catalogs.runReadCommand(             db.catalogs.updateOne(
db.catalogs.count(                      db.catalogs.findAndModify(              db.catalogs.getPagesInRAM(              db.catalogs.insert(                     db.catalogs.save(                       db.catalogs.validate(
db.catalogs.createIndex(                db.catalogs.findOne(                    db.catalogs.getPlanCache(               db.catalogs.insertMany(                 db.catalogs.setSlaveOk(                 db.catalogs.valueOf(
db.catalogs.createIndexes(              db.catalogs.findOneAndDelete(           db.catalogs.getQueryOptions(            db.catalogs.insertOne(                  db.catalogs.setWriteConcern(            db.catalogs.verify(
db.catalogs.dataSize(                   db.catalogs.findOneAndReplace(          db.catalogs.getShardDistribution(       db.catalogs.isCapped(                   db.catalogs.shellPrint(
db.catalogs.deleteMany(                 db.catalogs.findOneAndUpdate(           db.catalogs.getShardVersion(            db.catalogs.latencyStats(               db.catalogs.stats(
db.catalogs.deleteOne(                  db.catalogs.getCollection(              db.catalogs.getSlaveOk(                 db.catalogs.mapReduce(                  db.catalogs.storageSize(
db.catalogs.diskStorageStats(           db.catalogs.getDB(                      db.catalogs.getSplitKeysForChunks(      db.catalogs.pagesInRAM(                 db.catalogs.toLocaleString
db.catalogs.distinct(                   db.catalogs.getDiskStorageStats(        db.catalogs.getWriteConcern(            db.catalogs.propertyIsEnumerable        db.catalogs.toString(
> db.catalogs.find()
{ "_id" : ObjectId("5e8ddd33e220d7d6f73933ac"), "name" : "Процессоры" }
{ "_id" : ObjectId("5e8ddd33e220d7d6f73933ad"), "name" : "Мат.платы" }
{ "_id" : ObjectId("5e8ddd34e220d7d6f73933ae"), "name" : "Видеокарты" }

-- 6 задание

> db.products.insert(
...   {
...     name: 'Intel Core i3-8100',
...     description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
...     price: 7890.00,
...     catalog_id: new ObjectId("5e8ddd33e220d7d6f73933ac")
...   }
... );
WriteResult({ "nInserted" : 1 })
> 
> db.products.insert(
...   {
...     name: 'Intel Core i3-8100',
...     description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
...     price: 7890.00,
...     catalog_id: new ObjectId("5e8ddd33e220d7d6f73933ac")
...   }
... );
WriteResult({ "nInserted" : 1 })
> db.products.insert(
...   {
...     name: 'ASUS ROG MAXIMUS X HERO',
...     description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',
...     price: 19310.00,
...     catalog_id: new ObjectId("5b56c74788f700498cbdc56c")
...   }
... );
WriteResult({ "nInserted" : 1 })
> db.products.find()
{ "_id" : ObjectId("5e8dde3150de4206ebc50856"), "name" : "Intel Core i3-8100", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.", "price" : 7890, "catalog_id" : ObjectId("5e8ddd33e220d7d6f73933ac") }
{ "_id" : ObjectId("5e8dde3650de4206ebc50857"), "name" : "Intel Core i3-8100", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.", "price" : 7890, "catalog_id" : ObjectId("5e8ddd33e220d7d6f73933ac") }
{ "_id" : ObjectId("5e8dde3c50de4206ebc50858"), "name" : "ASUS ROG MAXIMUS X HERO", "description" : "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX", "price" : 19310, "catalog_id" : ObjectId("5b56c74788f700498cbdc56c") }

