-- 3.8.2_join_exercises.sql

use join_example_db;

select * from users;
select * from roles;

select users.name as user_name, roles.name as role_name
from users
join roles on users.role_id = roles.id;

select users.name as user_name, roles.name as role_name
from users
left join roles on users.role_id = roles.id;

select users.name as user_name, roles.name as role_name
from users
right join roles on users.role_id = roles.id;

select count(users.name), roles.name as role_name
from users
left join roles on users.role_id = roles.id
group by role_name;
