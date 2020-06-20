-- tickets table
START TRANSACTION;
INSERT INTO tickets(id, user_id, conference_id, coupon_code, ENUM('General-admission', 'VIP', 'Reserved-Seating', 'Early-bird-discount', 'Coded-discount'), price) VALUES (null,1,3,5,'VIP',1500.00);
COMMIT;

-- We can use "ROLLBACK" before "COMMIT" and reset the the all changes which were made after starting the transaction


--review_scores table
START TRANSACTION;
INSERT INTO (id, submission_id, completeness, subject_knowledge, comments) VALUES (null,1,3.2,4.2,'Need more improvements');
COMMIT;

--when updating the ratings we provided in review_scores table
START TRANSACTION;
UPDATE review_scores SET completeness = 4.5 WHERE submission_id = 1;
UPDATE review_scores SET subject_knowledge = 5.0 WHERE submission_id = 1;
COMMIT;
