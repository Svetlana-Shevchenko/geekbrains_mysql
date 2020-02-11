mysql> UPDATE users SET created_at = updated_at WHERE created_at > updated_at;
Query OK, 45 rows affected (0,09 sec)
Rows matched: 45  Changed: 45  Warnings: 0

mysql> SELECT * FROM profiles LIMIT 10;
+---------+------------+-----+----------------------+-----------------------+----------+---------------------+---------------------+
| user_id | birthdate  | sex | hometown             | country               | photo_id | created_at          | updated_at          |
+---------+------------+-----+----------------------+-----------------------+----------+---------------------+---------------------+
|       1 | 2002-12-12 |     | North Cierraside     | Antigua and Barbuda   |       40 | 1975-07-02 03:29:03 | 1997-10-26 11:06:08 |
|       2 | 1997-01-01 |     | Kovacekbury          | Azerbaijan            |       75 | 1973-12-27 18:12:47 | 1999-01-01 08:56:05 |
|       3 | 2008-12-02 |     | New Fredrick         | Cambodia              |       92 | 2011-10-23 19:10:36 | 2019-07-11 19:10:25 |
|       4 | 2015-10-06 |     | West Finn            | Saint Kitts and Nevis |       39 | 1998-07-06 14:57:26 | 1986-07-17 10:18:07 |
|       5 | 1980-12-09 |     | Lake Dane            | Indonesia             |       45 | 1988-01-29 06:07:03 | 2017-05-07 03:57:25 |
|       6 | 2003-03-22 |     | New Destineyhaven    | Estonia               |       24 | 2014-04-10 21:05:22 | 1990-01-05 19:55:24 |
|       7 | 1988-10-27 |     | Dorothyton           | Panama                |       56 | 2001-03-15 13:34:06 | 1999-09-17 11:57:53 |
|       8 | 1993-10-31 |     | Nitzschehaven        | Dominica              |       60 | 1990-01-03 05:19:51 | 1992-09-22 11:46:23 |
|       9 | 2002-04-23 |     | South Monaville      | Angola                |       84 | 1992-01-06 11:04:58 | 2002-05-25 21:34:07 |
|      10 | 2016-01-19 |     | West Kristianborough | Taiwan                |       71 | 2000-06-27 01:39:36 | 2010-06-03 18:29:58 |
+---------+------------+-----+----------------------+-----------------------+----------+---------------------+---------------------+
10 rows in set (0,01 sec)

mysql> CREATE TEMPORARY TABLE sex (sex CHAR(1));
Query OK, 0 rows affected (0,01 sec)

mysql> INSERT INTO sex VALUES ('m'), ('f');
Query OK, 2 rows affected (0,00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> UPDATE profiles SET sex = (SELECT sex FROM sex ORDER BY RAND() LIMIT 1);
Query OK, 100 rows affected (0,02 sec)
Rows matched: 100  Changed: 100  Warnings: 0

mysql> SELECT COUNT(*) FROM media
    -> ;
+----------+
| COUNT(*) |
+----------+
|      100 |
+----------+
1 row in set (0,01 sec)

mysql> UPDATE profiles SET photo_id = FLOOR(1 + (RAND() * 100));
Query OK, 99 rows affected (0,01 sec)
Rows matched: 100  Changed: 99  Warnings: 0

mysql> SHOW TABLES;
+---------------------+
| Tables_in_vk        |
+---------------------+
| communities         |
| communities_users   |
| friendship          |
| friendship_statuses |
| like_types          |
| likes               |
| media               |
| media_types         |
| messages            |
| profiles            |
| users               |
+---------------------+
11 rows in set (0,01 sec)

mysql> UPDATE messages SET
    -> from_user_id = FLOOR(1 + (RAND() * 100)),
    -> to_user_id = FLOOR(1 + (RAND() * 100));
Query OK, 100 rows affected (0,00 sec)
Rows matched: 100  Changed: 100  Warnings: 0

mysql> TRUNCATE media_types;
Query OK, 0 rows affected (0,03 sec)

mysql> INSERT INTO media_types (name) VALUES
    ->   ('photo'),
    ->   ('video'),
    ->   ('audio')
    -> ;
Query OK, 3 rows affected (0,01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> UPDATE media SET media_type_id = FLOOR(1 + (RAND() * 3));
Query OK, 70 rows affected (0,00 sec)
Rows matched: 100  Changed: 70  Warnings: 0

mysql> UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));
Query OK, 98 rows affected (0,02 sec)
Rows matched: 100  Changed: 98  Warnings: 0

mysql> UPDATE media SET filename = CONCAT('https://dropbox/vk/file_', size);
Query OK, 0 rows affected (0,00 sec)
Rows matched: 100  Changed: 0  Warnings: 0


mysql> UPDATE media SET metadata = CONCAT('{"owner":"',
    ->   (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
    ->   '"}');
Query OK, 98 rows affected (0,01 sec)
Rows matched: 100  Changed: 98  Warnings: 0

mysql> UPDATE friendship SET
    ->   user_id = FLOOR(1 + (RAND() * 100)),
    ->   friend_id = FLOOR(1 + (RAND() * 100))
    -> ;
Query OK, 100 rows affected (0,01 sec)
Rows matched: 100  Changed: 100  Warnings: 0

mysql> TRUNCATE friendship_statuses;
Query OK, 0 rows affected (0,02 sec)

mysql> INSERT INTO friendship_statuses (name)
    ->   VALUES ('Requested'), ('Confirmed'), ('Rejected');
Query OK, 3 rows affected (0,01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> UPDATE friendship SET status_id = FLOOR(1 + (RAND() * 2));
Query OK, 58 rows affected (0,01 sec)
Rows matched: 100  Changed: 58  Warnings: 0

mysql> DELETE FROM communities WHERE id > 20;
Query OK, 0 rows affected (0,00 sec)

mysql> UPDATE communities_users SET   community_id = FLOOR(1 + (RAND() * 10)),   user_id = FLOOR(1 + (RAND() * 100));
Query OK, 50 rows affected (0,00 sec)
Rows matched: 50  Changed: 50  Warnings: 0


