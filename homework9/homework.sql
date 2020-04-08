-- Прщшу прощения за задержку. Была очень большая нагрузка на работе ((
-- 1 Задание

mysql root@localhost:vk> CREATE INDEX profiles_birthdate_idx ON profiles(birthdate);
                      -> CREATE INDEX likes_target_id_idx ON likes(target_id);
Query OK, 0 rows affected
Query OK, 0 rows affected
Time: 0.167s
mysql root@localhost:vk> 
                      -> CREATE INDEX likes_target_id_target_type_id_idx 
                      ->   ON likes(target_id, target_type_id);
Query OK, 0 rows affected
mysql root@localhost:vk> ALTER TABLE media
                      ->   ADD CONSTRAINT media_user_id_fk 
                      ->     FOREIGN KEY (user_id) REFERENCES users(id);^I^I
                      ->     
                      -> ALTER TABLE posts
                      ->   ADD CONSTRAINT posts_user_id_fk 
                      ->     FOREIGN KEY (user_id) REFERENCES users(id);
                      -> 
                      -> ALTER TABLE profiles
                      ->   ADD CONSTRAINT profiles_user_id_fk 
                      ->     FOREIGN KEY (user_id) REFERENCES profiles(id); 
                      -> 
                      -> ALTER TABLE likes
                      ->   ADD CONSTRAINT likes_target_type_id_fk 
                      ->     FOREIGN KEY (target_type_id) REFERENCES likes(target_type_id);
Query OK, 0 rows affected
Query OK, 0 rows affected
Query OK, 0 rows affected
Time: 0.221s

mysql root@localhost:vk> 
                      -> SELECT
                      ->     TABLE_NAME,
                      ->     COLUMN_NAME,
                      ->     CONSTRAINT_NAME,
                      ->     REFERENCED_TABLE_NAME,
                      ->     REFERENCED_COLUMN_NAME
                      -> FROM
                      ->     INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                      -> WHERE
                      -> ^IREFERENCED_TABLE_SCHEMA = 'vk'
                      ->     AND REFERENCED_TABLE_NAME = 'media';
+--------------+---------------+-----------------------------+-------------------------+--------------------------+
| TABLE_NAME   | COLUMN_NAME   | CONSTRAINT_NAME             | REFERENCED_TABLE_NAME   | REFERENCED_COLUMN_NAME   |
|--------------+---------------+-----------------------------+-------------------------+--------------------------|
| profiles     | photo_id      | profiles_photo_id_fk        | media                   | id                       |
| likes        | target_id     | likes_target_id_media_id_fk | media                   | id                       |
+--------------+---------------+-----------------------------+-------------------------+--------------------------+
2 rows in set
Time: 0.017s


-- 2 Задание
mysql root@localhost:vk> SELECT DISTINCT 
                      ->   communities.name AS group_name,
                      ->   COUNT(communities_users.user_id) OVER() 
                      ->     / (SELECT COUNT(*) FROM communities) AS avg_users_in_groups,
                      ->   FIRST_VALUE(users.first_name) 
                      ->     OVER birthday_desc AS youngest_first_name,
                      ->   FIRST_VALUE(users.last_name) 
                      ->     OVER birthday_desc AS youngest_last_name,
                      ->   FIRST_VALUE(users.first_name) 
                      ->     OVER birthday_asc AS oldest_first_name,
                      ->   FIRST_VALUE(users.last_name) 
                      ->     OVER birthday_asc AS oldest_last_name,
                      ->   COUNT(communities_users.user_id) 
                      ->     OVER(PARTITION BY communities.id) AS users_in_groups,
                      ->   (SELECT COUNT(*) FROM users) AS users_total,
                      ->   COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) 
                      ->     / (SELECT COUNT(*) FROM users) *100 AS '%%'
                      ->     FROM communities
                      ->       LEFT JOIN communities_users 
                      ->         ON communities_users.community_id = communities.id
                      ->       LEFT JOIN users 
                      ->         ON communities_users.user_id = users.id
                      ->       LEFT JOIN profiles 
                      ->         ON profiles.user_id = users.id
                      ->       WINDOW birthday_desc AS (PARTITION BY communities.id ORDER BY profiles.birthdate DESC),
                      ->              birthday_asc AS (PARTITION BY communities.id ORDER BY profiles.birthdate);  
                      ->              
+--------------+-----------------------+-----------------------+----------------------+---------------------+--------------------+-------------------+---------------+------+
| group_name   |   avg_users_in_groups | youngest_first_name   | youngest_last_name   | oldest_first_name   | oldest_last_name   |   users_in_groups |   users_total |   %% |
|--------------+-----------------------+-----------------------+----------------------+---------------------+--------------------+-------------------+---------------+------|
| eum          |                3.3333 | Eduardo               | Mitchell             | Freda               | Mueller            |                 3 |           100 |    3 |
| quis         |                3.3333 | Vladimir              | Tillman              | Michele             | Murray             |                 3 |           100 |    3 |
| minima       |                3.3333 | Brandy                | Greenfelder          | Orlo                | D Amore            |                 4 |           100 |    4 |
| dolore       |                3.3333 | Vladimir              | Tillman              | Kadin               | Purdy              |                 9 |           100 |    9 |
| quas         |                3.3333 | Owen                  | McKenzie             | Lamar               | Dietrich           |                 8 |           100 |    8 |
| repellendus  |                3.3333 | Jesus                 | Bernhard             | Ciara               | Funk               |                10 |           100 |   10 |
| eos          |                3.3333 | Zoila                 | Collier              | Kadin               | Purdy              |                 4 |           100 |    4 |
| qui          |                3.3333 | Rowena                | Bogan                | Joany               | Yost               |                 5 |           100 |    5 |
| enim         |                3.3333 | Rossie                | Haley                | Rossie              | Haley              |                 1 |           100 |    1 |
| et           |                3.3333 | Sarah                 | Kuhn                 | Josephine           | Rice               |                 3 |           100 |    3 |
| hic          |                3.3333 | <null>                | <null>               | <null>              | <null>             |                 0 |           100 |    0 |
| veniam       |                3.3333 | <null>                | <null>               | <null>              | <null>             |                 0 |           100 |    0 |
| ut           |                3.3333 | <null>                | <null>               | <null>              | <null>             |                 0 |           100 |    0 |
| incidunt     |                3.3333 | <null>                | <null>               | <null>              | <null>             |                 0 |           100 |    0 |
| optio        |                3.3333 | <null>                | <null>               | <null>              | <null>             |                 0 |           100 |    0 |
+--------------+-----------------------+-----------------------+----------------------+---------------------+--------------------+-------------------+---------------+------+


-- 3. Задание на денормализацию
--- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

mysql root@localhost:vk> 
                      -> SELECT users.id,
                      ->   COUNT(DISTINCT messages.id) +
                      ->   COUNT(DISTINCT likes.id) +
                      ->   COUNT(DISTINCT media.id) AS activity
                      ->   FROM users
                      ->     LEFT JOIN messages
                      ->       ON users.id = messages.from_user_id
                      ->     LEFT JOIN likes
                      ->       ON users.id = likes.user_id
                      ->     LEFT JOIN media
                      ->       ON users.id = media.user_id
                      ->   GROUP BY users.id
                      ->   ORDER BY activity
                      ->   LIMIT 10;
+------+------------+
|   id |   activity |
|------+------------|
|   93 |          0 |
|   96 |          0 |
|   39 |          0 |
|   10 |          0 |
|   15 |          1 |
|   31 |          1 |
|   30 |          1 |
|    7 |          1 |
|    8 |          1 |
|   36 |          1 |
+------+------------+
10 rows in set
Time: 0.005s


