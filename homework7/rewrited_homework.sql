mysql root@localhost:vk> SELECT COUNT(*) FROM ( 
                      ->   SELECT  TIMESTAMPDIFF(YEAR, profiles.birthdate, NOW()) as age 
                      ->     FROM likes
                      ->     JOIN profiles ON likes.target_id = profiles.user_id
                      ->     JOIN target_types ON likes.target_type_id = target_types.id AND target_types.name = "users"
                      ->   ORDER BY age LIMIT 10) as age_likes;
+------------+
|   COUNT(*) |
|------------|
|         10 |
+------------+
1 row in set
Time: 0.003s


mysql root@localhost:vk> SELECT COUNT(likes.id), profiles.sex 
                      ->   FROM likes 
                      ->   JOIN profiles ON likes.target_id = profiles.user_id
                      -> GROUP BY profiles.sex
                      -> ;
+-------------------+-------+
|   COUNT(likes.id) | sex   |
|-------------------+-------|
|                44 | m     |
|                56 | f     |
+-------------------+-------+
2 rows in set
Time: 0.002s

mysql root@localhost:vk> SELECT user_id, COUNT(user_id) as activity FROM likes GROUP BY user_id order by activity LIMIT 10;
+-----------+------------+
|   user_id |   activity |
|-----------+------------|
|        42 |          1 |
|        62 |          1 |
|        82 |          1 |
|        43 |          1 |
|        81 |          1 |
|       100 |          1 |
|        48 |          1 |
|        99 |          1 |
|        60 |          1 |
|        20 |          1 |
+-----------+------------+
10 rows in set
Time: 0.003s
