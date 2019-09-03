show databases;

-- mysql.user means use the mysql database and read from the user table
select * from mysql.user;

-- the user and host columns from the user table
SELECT user, host FROM mysql.user;

-- select all columns from the help_topic table on the mysql databse
SELECT * FROM mysql.help_topic;

-- select only the help_topic_id, help_category_id, and url columns from help_topic table on mysql
SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;