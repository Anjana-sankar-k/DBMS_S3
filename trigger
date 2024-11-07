mysql> create database event;
Query OK, 1 row affected (0.01 sec)

mysql> use event;
Database changed
mysql> create table participant(player_id int primary key, name varchar(100), event_id int, gender char(1), year int);
Query OK, 0 rows affected (0.03 sec)

mysql> create table prizes(prize_id int primary key AUTO_INCREMENT, money decimal(10,2), event_id int,prize_rank int, year int);
Query OK, 0 rows affected (0.03 sec)

mysql> create table winners(prize_id int, player_id int, primary key(prize_id, player_id), foreign key(prize_id) references prizes(prize_id), foreign key(player_id) references participant(player_id));
Query OK, 0 rows affected (0.03 sec)

mysql> create table events(event_id int primary key, event_name varchar(100), description varchar(255), year int);
Query OK, 0 rows affected (0.02 sec)

mysql> DELIMITER //
mysql> create trigger add_prizes_after_event after insert on events for each row begin insert into prizes(money, event_id, prize_rank, year) values (1500, NEW.event_id, 1, NEW.year);
    -> insert into prizes(money, event_id, prize_rank, year) values (1000, NEW.event_id, 2, NEW.year);
    -> insert into prizes(money, event_id, prize_rank, year) values (500, NEW.event_id, 3, NEW.year);
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER ;
mysql> insert into event(event_id, event_name, description, year) values (2, 'Hackathon', 'where innovation meets creativity', 2024);
ERROR 1146 (42S02): Table 'event.event' doesn't exist
mysql> insert into events(event_id, event_name, description, year) values (2, 'Hackathon', 'where innovation meets creativity', 2024);
Query OK, 1 row affected (0.01 sec)

mysql> select * from prizes;
+----------+---------+----------+------------+------+
| prize_id | money   | event_id | prize_rank | year |
+----------+---------+----------+------------+------+
|        1 | 1500.00 |        2 |          1 | 2024 |
|        2 | 1000.00 |        2 |          2 | 2024 |
|        3 |  500.00 |        2 |          3 | 2024 |
+----------+---------+----------+------------+------+
3 rows in set (0.00 sec)


