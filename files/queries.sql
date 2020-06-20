-- queries used in coupen_codes table
---------------------------------------------------------
-- find all coupen codes available for a specific conference 
SELECT * FROM coupen_codes WHERE conference_id = '${conferenceId}'

-- adding a new coupen_code 
INSERT INTO coupen_codes(conference_id, vendor, coupon_code, discount)
    VALUES(${coupen.conferenceId}, ${coupen.vendor}, ${coupen.coupen_code}, ${coupen.discount})

-- updating a coupen_code details using conferenceId and coupen_code name
UPDATE coupen_codes SET vendor=${coupen.vendor}, discount=${coupen.discount} 
    WHERE conference_id = '${coupen.conferenceId}' AND coupen_code='${coupen.coupen_code}'

-- deleting a coupen_code details using conferenceId and coupen_code name
DELETE FROM coupen_codes 
    WHERE conference_id = '${coupen.conferenceId}' AND coupen_code='${coupen.coupen_code}' LIMIT 1



-- queries used in tickets table
-------------------------------------
-- find ticket details of a participant
SELECT * FROM tickets WHERE conference_id = '${conferenceId}' AND user_id='${req.user.id}'

-- adding a new ticket detail when a user buy ticket
INSERT INTO tickets(user_id, conference_id, coupon_code, type, price)
    VALUES(${req.user.id}, ${ticket.conferenceId}, ${ticket.coupon_code}, ${ticket.type}, ${ticket.price})

-- updating a ticket details based on ticketID, confereneceId and ticket owner's user id (only ticket owner can update his ticket details)
UPDATE tickets SET coupon_code=${ticket.coupon_code}, type=${ticket.type}, price=${ticket.price} 
    WHERE id = '${req.params.ticketId}' AND conference_id = '${conferenceId}' AND user_id='${req.user.id}' LIMIT 1

-- deleting a ticket details based on ticketID, confereneceId and ticket owner's user id (only ticket owner can delete his ticket details)
DELETE FROM tickets 
    WHERE id = '${req.params.ticketId}' AND conference_id = '${conferenceId}' AND user_id='${req.user.id}' LIMIT 1



-- queries used in countries table
------------------------------------------------
-- finding all country details avialable in the database
SELECT * FROM countries

-- finding country details of a specific user using his userID
SELECT * FROM countries WHERE code = 
    (SELECT country_code FROM users WHERE id='${userId}' LIMIT 1) LIMIT 1

-- adding a new country
INSERT INTO countries(code, name, flag) 
    VALUES(${country.code}, ${country.name}, ${country.flag})

-- update a country's details
UPDATE countries SET name=${country.code}, flag=${country.flag} 
    WHERE code='${country.code}' LIMIT 1



-- queries used in coupen_codes table
---------------------------------------------------------
-- find all coupen codes available for a specific conference 
SELECT * FROM coupen_codes WHERE conference_id = '${conferenceId}'

-- adding a new coupen_code 
INSERT INTO coupen_codes(conference_id, vendor, coupon_code, discount)
    VALUES(${coupen.conferenceId}, ${coupen.vendor}, ${coupen.coupen_code}, ${coupen.discount})

-- updating a coupen_code details using conferenceId and coupen_code name
UPDATE coupen_codes SET vendor=${coupen.vendor}, discount=${coupen.discount} 
    WHERE conference_id = '${coupen.conferenceId}' AND coupen_code='${coupen.coupen_code}'

-- deleting a coupen_code details using conferenceId and coupen_code name
DELETE FROM coupen_codes 
    WHERE conference_id = '${coupen.conferenceId}' AND coupen_code='${coupen.coupen_code}' LIMIT 1


    
-- queries related to roles and role_user tables
--------------------------------------------------
-- find all user roles
SELECT * FROM roles

-- finding user role's details of a specific user
SELECT * FROM roles WHERE id = 
    (SELECT role_id FROM role_user WHERE id='${userId}' LIMIT 1) LIMIT 1

-- set default user role 'Author' to every new users while registering (any registerd persons can submit articles)
INSERT INTO role_user(user_id, role_id)
    VALUES(${req.user.id}, (SELECT id FROM roles WHERE name='Author' LIMIT 1))

-- update user role for a specific user
UPDATE role_user SET role_id=(SELECT id FROM roles WHERE name='${roleUser.role}' LIMIT 1) 
    WHERE user_id='${roleUser.roleId}'




-- queries used in subjects table
---------------------------------------
-- find all subjects
SELECT * FROM subjects

-- adding a new subject
INSERT INTO subjects(name, description) 
    VALUES(${subject.name}, ${subject.description})

-- update subject details for a specific subject
UPDATE subjects SET name=${subject.name}, description=${subject.description} 
    WHERE id='${subject.id}' LIMIT 1




-- queries used in review_scores table
-----------------------------------------
-- finding all review_scores
SELECT * FROM review_scores

-- finding all review_scores for a specific submiision
SELECT * FROM review_scores WHERE submission_id=${req.params.submissionId}

-- add new review_score
INSERT INTO review_scores(submission_id, completeness, subject_knowledge, comments) 
    VALUES(${score.submission_id}, ${score.completeness}, ${score.subject_knowledge}, ${score.comments})

-- updating a specific review_score
UPDATE review_scores SET completeness=${score.completeness}, subject_knowledge=${score.subject_knowledge}, comments=${score.comments}
    WHERE submission_id='${score.submission_id}' LIMIT 1

-- deleting a specific review_score
DELETE FROM review_scores 
    WHERE submission_id = '${req.params.submissionId}' LIMIT 1




-- queries used in conferences table
----------------------------------------------------
-- finding all details of a conference using conferenceId 
SELECT * FROM conferences WHERE id = '" + conferenceId + "' LIMIT 1

-- adding a new conference details
INSERT INTO conferences(title, description, date, venue, total_seats, available_seats) VALUES("
     + conference.title + ", " + conference.description + ", " + conference.date + ", " + 
     conference.venue + ", " + conference.total_seats + ", " + conference.available_seats + ")

-- updateing a conference details using conferenceID
UPDATE conferences SET fld1=vl1, fld2=val2 WHERE id = '" + conferenceId + "' LIMIT 1
DELETE FROM conferences WHERE id = '" + conferenceId + "' LIMIT 1




-- queries used in submissions table
--------------------------------------
-- find all submissions
SELECT * FROM submissions

-- find a specific submission using submisionID
SELECT * FROM submissions WHERE id='${req.params.submissionId}'

-- adding a new submission
INSERT INTO submissions(user_id, subject_id, title, co_authors, status, file)
    VALUES(${req.user.id}, ${submission.subject_id}, ${submission.title}, ${submission.co_authors}, ${submission.status}, ${submission.file})

-- updating a submission using submissionID and user id of the submitter(to make sure only a submitter can update his submission) 
UPDATE submissions SET subject_id=${submission.subject_id}, 
    title=${submission.title}, co_authors=${submission.co_authors}, file=${submission.filename}
    WHERE id=${req.params.submissionId} AND user_id=${req.user.id}

-- deleting a submission using submissionID (admins can delete anyone submission)
DELETE FROM submissions WHERE id=${req.params.submissionId}

-- deleting a submission using submissionID and user id of the submitter(to make sure only a submitter can delete his submission) 
DELETE FROM submissions WHERE id=${req.params.submissionId} AND user_id=${req.user.id}




-- queries used in authentication
----------------------------------------------------
-- finding a particular user using his email address
SELECT * FROM users WHERE email = '${userData.email}' LIMIT 1

-- finding the user role of a user using there 'user id'
SELECT name FROM roles 
    WHERE id = (SELECT role_id FROM role_user WHERE user_id ='${req.user.id}' LIMIT 1)

-- register a new user with there details
INSERT INTO users(first_name, last_name, email, password, country_code) 
      VALUES ('${userData.first_name}','${userData.last_name}','${userData.email}','${userData.password}','${userData.country_code}')




--Find the country code using the country name 
SELECT code FROM countries WHERE name='Sri Lanka';

--Name of the countries of participants those who were submitted the research papers 
SELECT DISTINCT users.country_code FROM (submissions LEFT JOIN users ON submissions.user_id=users.id);

--Get submission details from United States using the country code
SELECT submissions.* FROM (submissions INNER JOIN users ON submissions.user_id=users.id) WHERE users.country_code='US';

--Get submission details from United States
SELECT submissions.* FROM (submissions INNER JOIN users ON submissions.user_id=users.id) WHERE users.country_code IN (SELECT code FROM countries WHERE name='United States');

--Number of conferences to be held
SELECT COUNT(venue) FROM conferences;

--Get the conference revenue by countries
SELECT SUM(price) FROM tickets WHERE tickets.user_id IN (SELECT users.id FROM users WHERE users.country_code IN (SELECT code FROM countries WHERE name='Algeria'));

--Names of the countries the people bought tickets for the conference
SELECT countries.name from countries where countries.code IN (SELECT country_code from (users inner join tickets on users.id=tickets.user_id));

--Name list of the users whose submissions are accepted/rejected
SELECT DISTINCT CONCAT(users.first_name," ",users.last_name) FROM (users INNER JOIN submissions ON users.id=submissions.user_id) WHERE submissions.status='approved';

--Find the submissions and there status of a user by providing the his/her id 
SELECT submissions.id,submissions.status FROM (users INNER JOIN submissions ON users.id=submissions.user_id) WHERE users.id=10;

--Find the number of submissions(submission count) from a subject
SELECT COUNT(id) FROM submissions WHERE submissions.subject_id IN (SELECT id FROM subjects WHERE name='libero'); 

--Get rejected submission titles with the corresponding user details
SELECT submissions.title, users.id, CONCAT(users.first_name," ",users.last_name) FROM (submissions INNER JOIN users ON submissions.user_id=users.id) WHERE submissions.status='rejected';



