-- Pagination to redcue load
-- page 1 - (records 01-10): offset = 0, limit=10;
-- page 2 - (records 11-20) offset = 10, limit =10;
-- for example

-- get the users with first name, last name and email page 1
SELECT first_name,last_name,email FROM users LIMIT 10 OFFSET 0;
-- get the approved submissions page 2
SELECT * FROM submissions WHERE status='approved' LIMIT 10 OFFSET 10;
-- get the sold tickets for the confrecnce 2 page 1
SELECT * from tickets WHERE conference_id = 2 LIMIT 10 OFFSET 0;


-- make use of indexes created
-- the following query did not use the indexes created
explain select * from users where first_name like "%john%" or last_name like "%john%";

-- after removing the wildcard it used the indexes of first name and last name
explain select * from users where first_name like "john%" or last_name like "john%";


-- this particular query needs to be executed as root or db_admin since altering involved
-- make use of full text
-- first alter the table
Alter table users ADD FULLTEXT (first_name, last_name);
--- now use match
explain select * from users where match(first_name, last_name) AGAINST ('john');

-- push project statements down the query tree
-- situation where need to list submission title with user name
select first_name,last_name,title from users,submissions where submissions.user_id = users.id;

-- select coupon codes and the vendors with the conefrence title and veneue
select title,venue,coupon_code,vendor from conferences, coupon_codes where conferences.id = coupon_codes.conference_id;

-- select submission title with username and the subject name
select  users.first_name, users.last_name, submissions.title, subjects.name
from submissions,users,subjects
where submissions.user_id = users.id and submissions.subject_id = subjects.id;