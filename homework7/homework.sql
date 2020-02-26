mysql root@localhost:(none)> use vk;
You are now connected to database "vk" as user "root"
Time: 0.001s
mysql root@localhost:vk> desc profiles;
+------------+--------------+--------+-------+-------------------+-----------------------------------------------+
| Field      | Type         | Null   | Key   | Default           | Extra                                         |
|------------+--------------+--------+-------+-------------------+-----------------------------------------------|
| user_id    | int unsigned | NO     | PRI   | <null>            |                                               |
| birthdate  | date         | YES    |       | <null>            |                                               |
| sex        | char(1)      | NO     |       | <null>            |                                               |
| hometown   | varchar(100) | YES    |       | <null>            |                                               |
| country    | varchar(100) | YES    |       | <null>            |                                               |
| photo_id   | int unsigned | YES    |       | <null>            |                                               |
| created_at | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED                             |
| updated_at | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |
+------------+--------------+--------+-------+-------------------+-----------------------------------------------+
8 rows in set
Time: 0.006s
mysql root@localhost:vk> ALTER TABLE profiles
                      ->   ADD CONSTRAINT profiles_user_id_fk 
                      ->     FOREIGN KEY (user_id) REFERENCES users(id)
                      ->       ON DELETE CASCADE,
                      ->   ADD CONSTRAINT profiles_photo_id_fk
                      ->     FOREIGN KEY (photo_id) REFERENCES media(id)
                      ->       ON DELETE SET NULL;
                      -> 
Query OK, 100 rows affected
Time: 0.162s
mysql root@localhost:vk> DESC profiles;
+------------+--------------+--------+-------+-------------------+-----------------------------------------------+
| Field      | Type         | Null   | Key   | Default           | Extra                                         |
|------------+--------------+--------+-------+-------------------+-----------------------------------------------|
| user_id    | int unsigned | NO     | PRI   | <null>            |                                               |
| birthdate  | date         | YES    |       | <null>            |                                               |
| sex        | char(1)      | NO     |       | <null>            |                                               |
| hometown   | varchar(100) | YES    |       | <null>            |                                               |
| country    | varchar(100) | YES    |       | <null>            |                                               |
| photo_id   | int unsigned | YES    | MUL   | <null>            |                                               |
| created_at | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED                             |
| updated_at | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |
+------------+--------------+--------+-------+-------------------+-----------------------------------------------+
8 rows in set
Time: 0.003s
mysql root@localhost:vk> DESC profiles;
+------------+--------------+--------+-------+-------------------+-----------------------------------------------+
| Field      | Type         | Null   | Key   | Default           | Extra                                         |
|------------+--------------+--------+-------+-------------------+-----------------------------------------------|
| user_id    | int unsigned | NO     | PRI   | <null>            |                                               |
| birthdate  | date         | YES    |       | <null>            |                                               |
| sex        | char(1)      | NO     |       | <null>            |                                               |
| hometown   | varchar(100) | YES    |       | <null>            |                                               |
| country    | varchar(100) | YES    |       | <null>            |                                               |
| photo_id   | int unsigned | YES    | MUL   | <null>            |                                               |
| created_at | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED                             |
| updated_at | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |
+------------+--------------+--------+-------+-------------------+-----------------------------------------------+
8 rows in set
Time: 0.002s
mysql root@localhost:vk> SELECT * from profiles limit 1;
+-----------+-------------+-------+------------------+---------------------+------------+---------------------+---------------------+
|   user_id | birthdate   | sex   | hometown         | country             |   photo_id | created_at          | updated_at          |
|-----------+-------------+-------+------------------+---------------------+------------+---------------------+---------------------|
|         1 | 2002-12-12  | f     | North Cierraside | Antigua and Barbuda |         61 | 1975-07-02 03:29:03 | 2020-02-15 13:38:13 |
+-----------+-------------+-------+------------------+---------------------+------------+---------------------+---------------------+
1 row in set
Time: 0.001s
mysql root@localhost:vk> ALTER TABLE profiles DROP FOREIGN KEY profles_user_id_fk;
                      -> ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;
(1091, "Can't DROP 'profles_user_id_fk'; check that column/key exists")
mysql root@localhost:vk> ALTER TABLE profiles
                      ->   ADD CONSTRAINT profiles_user_id_fk 
                      ->     FOREIGN KEY (user_id) REFERENCES users(id)
                      ->       ON DELETE CASCADE,
                      ->   ADD CONSTRAINT profiles_photo_id_fk
                      ->     FOREIGN KEY (photo_id) REFERENCES media(id)
                      ->       ON DELETE SET NULL;
                      -> 
(1826, "Duplicate foreign key constraint name 'profiles_user_id_fk'")
mysql root@localhost:vk> desc profiles;
+------------+--------------+--------+-------+-------------------+-----------------------------------------------+
| Field      | Type         | Null   | Key   | Default           | Extra                                         |
|------------+--------------+--------+-------+-------------------+-----------------------------------------------|
| user_id    | int unsigned | NO     | PRI   | <null>            |                                               |
| birthdate  | date         | YES    |       | <null>            |                                               |
| sex        | char(1)      | NO     |       | <null>            |                                               |
| hometown   | varchar(100) | YES    |       | <null>            |                                               |
| country    | varchar(100) | YES    |       | <null>            |                                               |
| photo_id   | int unsigned | YES    | MUL   | <null>            |                                               |
| created_at | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED                             |
| updated_at | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |
+------------+--------------+--------+-------+-------------------+-----------------------------------------------+
8 rows in set
Time: 0.004s
mysql root@localhost:vk> DESC messages;
+--------------+--------------+--------+-------+-------------------+-------------------+
| Field        | Type         | Null   | Key   | Default           | Extra             |
|--------------+--------------+--------+-------+-------------------+-------------------|
| id           | int unsigned | NO     | PRI   | <null>            | auto_increment    |
| from_user_id | int unsigned | NO     |       | <null>            |                   |
| to_user_id   | int unsigned | NO     |       | <null>            |                   |
| body         | text         | NO     |       | <null>            |                   |
| is_important | tinyint(1)   | YES    |       | <null>            |                   |
| is_delivered | tinyint(1)   | YES    |       | <null>            |                   |
| created_at   | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+--------------+--------------+--------+-------+-------------------+-------------------+
7 rows in set
Time: 0.004s
mysql root@localhost:vk> ALTER TABLE messages
                      ->   ADD CONSTRAINT messages_from_user_id_fk 
                      ->     FOREIGN KEY (from_user_id) REFERENCES users(id),
                      ->   ADD CONSTRAINT messages_to_user_id_fk 
                      ->     FOREIGN KEY (to_user_id) REFERENCES users(id);
Query OK, 100 rows affected
Time: 0.135s
mysql root@localhost:vk> ALTER TABLE communities_users 
                      ->   ADD CONSTRAINT communities_id_fk
                      ->     FOREIGN KEY (community_id) REFERENCES communities(id)
                      ->   ADD CONSTRAINT communities_user_id_fk
                      ->     FOREIGN KEY (user_id) REFERENCES users(id);
(1064, "You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'ADD CONSTRAINT communities_user_id_fk\n    FOREIGN KEY (user_id) REFERENCES users' at line 4")
mysql root@localhost:vk> ALTER TABLE communities_users 
                      ->   ADD CONSTRAINT communities_id_fk
                      ->     FOREIGN KEY (community_id) REFERENCES communities(id),
                      ->   ADD CONSTRAINT communities_user_id_fk
                      ->     FOREIGN KEY (user_id) REFERENCES users(id);
Query OK, 50 rows affected
Time: 0.131s
mysql root@localhost:vk> ALTER TABLE friendship 
                      ->   ADD CONSTRAINT friendship_user_id_fk
                      ->     FOREIGN KEY (user_id) REFERENCES users(id),
                      ->   ADD CONSTRAINT friendship_friend_id_fk
                      ->     FOREIGN KEY (friend_id) REFERENCES users(id),
                      ->   ADD CONSTRAINT friendship_status_id_fk
                      ->     FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);
Query OK, 100 rows affected
Time: 0.434s
mysql root@localhost:vk> ALTER TABLE likes
                      ->   ADD CONSTRAINT likes_user_id_fk 
                      ->     FOREIGN KEY (user_id) REFERENCES users(id),
                      ->   ADD CONSTRAINT likes_target_id_fk
                      ->     FOREIGN KEY (target_id) REFERENCES users(id),
                      ->   ADD CONSTRAINT likes_target_type_id_fk
                      ->     FOREIGN KEY (target_type_id) REFERENCES target_type(id);
(1824, "Failed to open the referenced table 'target_type'")
mysql root@localhost:vk> ALTER TABLE likes
                      ->   ADD CONSTRAINT likes_user_id_fk 
                      ->     FOREIGN KEY (user_id) REFERENCES users(id),
                      ->   ADD CONSTRAINT likes_target_id_fk
                      ->     FOREIGN KEY (target_id) REFERENCES users(id),
                      ->   ADD CONSTRAINT likes_target_type_id_fk
                      ->     FOREIGN KEY (target_type_id) REFERENCES target_types(id);
Query OK, 100 rows affected
Time: 0.378s
mysql root@localhost:vk> ALTER TABLE media
                      ->   ADD CONSTRAINT media_type_id_fk 
                      ->     FOREIGN KEY (media_type_id) REFERENCES media_types(id),
                      ->   ADD CONSTRAINT media_user_id_fk
                      ->     FOREIGN KEY (user_id) REFERENCES users(id);
Query OK, 100 rows affected
Time: 0.135s
mysql root@localhost:vk> ALTER TABLE likes
                      ->   ADD CONSTRAINT likes_target_id_fk
                      ->     FOREIGN KEY (target_id) REFERENCES media(id);
(1826, "Duplicate foreign key constraint name 'likes_target_id_fk'")
mysql root@localhost:vk> ALTER TABLE likes
                      ->   ADD CONSTRAINT likes_target_id_media_id_fk
                      ->     FOREIGN KEY (target_id) REFERENCES media(id);
Query OK, 100 rows affected
Time: 0.141s
mysql root@localhost:vk> DESC likes;
+----------------+--------------+--------+-------+-------------------+-------------------+
| Field          | Type         | Null   | Key   | Default           | Extra             |
|----------------+--------------+--------+-------+-------------------+-------------------|
| id             | int unsigned | NO     | PRI   | <null>            | auto_increment    |
| user_id        | int unsigned | NO     | MUL   | <null>            |                   |
| target_id      | int unsigned | NO     | MUL   | <null>            |                   |
| target_type_id | int unsigned | NO     | MUL   | <null>            |                   |
| created_at     | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+----------------+--------------+--------+-------+-------------------+-------------------+
5 rows in set
Time: 0.003s
mysql root@localhost:vk> desc like_types;
+---------+--------------+--------+-------+-----------+----------------+
| Field   | Type         | Null   | Key   |   Default | Extra          |
|---------+--------------+--------+-------+-----------+----------------|
| id      | int unsigned | NO     | PRI   |    <null> | auto_increment |
| name    | varchar(255) | NO     | UNI   |    <null> |                |
+---------+--------------+--------+-------+-----------+----------------+
2 rows in set
Time: 0.003s
mysql root@localhost:vk> ALTER TABLE likes
                      ->   ADD COLUMN like_typ_id INT NULL;
Query OK, 0 rows affected
Time: 0.034s
mysql root@localhost:vk> desc likes;
+----------------+--------------+--------+-------+-------------------+-------------------+
| Field          | Type         | Null   | Key   | Default           | Extra             |
|----------------+--------------+--------+-------+-------------------+-------------------|
| id             | int unsigned | NO     | PRI   | <null>            | auto_increment    |
| user_id        | int unsigned | NO     | MUL   | <null>            |                   |
| target_id      | int unsigned | NO     | MUL   | <null>            |                   |
| target_type_id | int unsigned | NO     | MUL   | <null>            |                   |
| created_at     | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| like_typ_id    | int          | YES    |       | <null>            |                   |
+----------------+--------------+--------+-------+-------------------+-------------------+
6 rows in set
Time: 0.003s
mysql root@localhost:vk> ALTER TABLE likes                                                                                                                                                                                     
                      ->   ADD CONSTRAINT likes_                                                                                                                                                                               
mysql root@localhost:vk> ALTER TABLE likes 
                      ->   DROP COLUMN like_typ_id;
Query OK, 0 rows affected
Time: 0.248s
mysql root@localhost:vk> desc likes;
+----------------+--------------+--------+-------+-------------------+-------------------+
| Field          | Type         | Null   | Key   | Default           | Extra             |
|----------------+--------------+--------+-------+-------------------+-------------------|
| id             | int unsigned | NO     | PRI   | <null>            | auto_increment    |
| user_id        | int unsigned | NO     | MUL   | <null>            |                   |
| target_id      | int unsigned | NO     | MUL   | <null>            |                   |
| target_type_id | int unsigned | NO     | MUL   | <null>            |                   |
| created_at     | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+----------------+--------------+--------+-------+-------------------+-------------------+
5 rows in set
Time: 0.003s
mysql root@localhost:vk> ALTER TABLE likes
                      ->   MODIFY COLUMN like_type_id int UNSIGNED NOT NULL,
                      ->   ADD KEY(like_type_id)
                      ->   ;
Query OK, 0 rows affected
Time: 0.052s
mysql root@localhost:vk> ALTER TABLE likes
                      ->   ADD CONSTRAINT likes_type_id_fk
                      ->     FOREIGN KEY (like_type_id) REFERENCES like_types(id);
(1452, 'Cannot add or update a child row: a foreign key constraint fails (`vk`.`#sql-3a6_b`, CONSTRAINT `likes_type_id_fk` FOREIGN KEY (`like_type_id`) REFERENCES `like_types` (`id`))')
mysql root@localhost:vk> desc likes;
+----------------+--------------+--------+-------+-------------------+-------------------+
| Field          | Type         | Null   | Key   | Default           | Extra             |
|----------------+--------------+--------+-------+-------------------+-------------------|
| id             | int unsigned | NO     | PRI   | <null>            | auto_increment    |
| user_id        | int unsigned | NO     | MUL   | <null>            |                   |
| target_id      | int unsigned | NO     | MUL   | <null>            |                   |
| target_type_id | int unsigned | NO     | MUL   | <null>            |                   |
| created_at     | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| like_type_id   | int unsigned | NO     | MUL   | <null>            |                   |
+----------------+--------------+--------+-------+-------------------+-------------------+
6 rows in set
Time: 0.002s
mysql root@localhost:vk> select * from like_types;
+------+-----------+
|   id | name      |
|------+-----------|
|    3 | community |
|    2 | media     |
|    1 | user      |
+------+-----------+
3 rows in set
Time: 0.001s                                                                                                                                         
mysql root@localhost:vk> UPDATE likes SET like_type_id = FLOOR(RAND()*3);
Query OK, 69 rows affected
Time: 0.013s
mysql root@localhost:vk> SELECT like_type_id from likes GROUP BY like_type_id;
+----------------+
|   like_type_id |
|----------------|
|              0 |
|              1 |
|              2 |
+----------------+
3 rows in set
Time: 0.001s
mysql root@localhost:vk> ALTER TABLE likes
                      ->   ADD CONSTRAINT like_type_id_fk
                      ->     FOREIGN KEY (like_type_id) REFERENCES like_types(id);
(1452, 'Cannot add or update a child row: a foreign key constraint fails (`vk`.`#sql-3a6_b`, CONSTRAINT `like_type_id_fk` FOREIGN KEY (`like_type_id`) REFERENCES `like_types` (`id`))')
mysql root@localhost:vk> select * from like_types;
+------+-----------+
|   id | name      |
|------+-----------|
|    3 | community |
|    2 | media     |
|    1 | user      |
+------+-----------+
3 rows in set
Time: 0.001s
mysql root@localhost:vk> UPDATE likes SET like_type_id = FLOOR(1+RAND()*3);
Query OK, 83 rows affected
Time: 0.024s
mysql root@localhost:vk> ALTER TABLE likes
                      ->   ADD CONSTRAINT like_type_id_fk
                      ->     FOREIGN KEY (like_type_id) REFERENCES like_types(id);
Query OK, 100 rows affected
Time: 0.156s
mysql root@localhost:vk> SELECT * from review_statuses;
+------+-----------+
|   id | name      |
|------+-----------|
|    4 | Disliked  |
|    3 | Liked     |
|    1 | Unwatched |
|    2 | Watched   |
+------+-----------+
4 rows in set
Time: 0.001s
mysql root@localhost:vk> SELECT * from friendship_statuses;
+------+-----------+
|   id | name      |
|------+-----------|
|    2 | Confirmed |
|    3 | Rejected  |
|    1 | Requested |
+------+-----------+
3 rows in set
Time: 0.002s
mysql root@localhost:vk> desc likes;
+----------------+--------------+--------+-------+-------------------+-------------------+
| Field          | Type         | Null   | Key   | Default           | Extra             |
|----------------+--------------+--------+-------+-------------------+-------------------|
| id             | int unsigned | NO     | PRI   | <null>            | auto_increment    |
| user_id        | int unsigned | NO     | MUL   | <null>            |                   |
| target_id      | int unsigned | NO     | MUL   | <null>            |                   |
| target_type_id | int unsigned | NO     | MUL   | <null>            |                   |
| created_at     | datetime     | YES    |       | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| like_type_id   | int unsigned | NO     | MUL   | <null>            |                   |
+----------------+--------------+--------+-------+-------------------+-------------------+
6 rows in set
Time: 0.002s
mysql root@localhost:vk> SELECT * from event_types;
+------+---------+
|   id | name    |
|------+---------|
|    2 | media   |
|    3 | message |
|    1 | post    |
+------+---------+
3 rows in set
Time: 0.001s

