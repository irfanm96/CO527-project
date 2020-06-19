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


-- push project statements down the query tree
