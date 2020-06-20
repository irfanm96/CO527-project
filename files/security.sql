
-- this script should be run as the root account of the database server since it involves creating users and granting permissions
-- Folowwing are the tables in the cms database
        -- countries
        -- roles
        -- subjects
        -- users
        -- role_user
        -- submissions
        -- review_scores
        -- support_tickets
        -- conferences
        -- tickets
        -- coupon_codes

-- create users called db_admin and backend_dev
DROP USER IF EXISTS 'db_admin'@'localhost';
DROP USER IF EXISTS 'backend_dev'@'localhost';

CREATE USER 'db_admin'@'localhost' IDENTIFIED BY 'db_admin123';
CREATE USER 'backend_dev'@'localhost' IDENTIFIED BY 'backend_dev123';

-- initially give all permissions to db admin
-- mysql supports only grants on one object so need to grant permssions indidually to all tables since some tables have special restrictions
-- partial revokes are not used (avoided) since it add more complexity to the implementation

GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER, DELETE ON cms.countries TO 'db_admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER, DELETE ON cms.roles TO 'db_admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER, DELETE ON cms.subjects TO 'db_admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER, DELETE ON cms.users TO 'db_admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER, DELETE ON cms.role_user TO 'db_admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER, DELETE ON cms.review_scores TO 'db_admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER, DELETE ON cms.support_tickets TO 'db_admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER, DELETE ON cms.conferences TO 'db_admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER, DELETE ON cms.coupon_codes TO 'db_admin'@'localhost';

-- first give delete permission on the submission table, and a before delete trigger will be used to stop deleting approved submissions
GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER, DELETE ON cms.submissions TO 'db_admin'@'localhost';

-- dont give delete permissions for tickets table
GRANT SELECT, INSERT, UPDATE, INDEX, CREATE, ALTER ON cms.tickets TO 'db_admin'@'localhost';

-- grant permission to create view
GRANT CREATE VIEW ON cms.* TO 'db_admin'@'localhost';

FLUSH PRIVILEGES;

-- check the permissions now
SHOW GRANTS FOR 'db_admin'@'localhost';

-- a trigger to manage delete actions on the submissions table
-- so no approved submissions will be deleted
USE cms;
DELIMITER $$
DROP TRIGGER IF EXISTS before_delete_on_submissions;
CREATE TRIGGER before_delete_on_submissions
BEFORE DELETE
ON cms.submissions
FOR EACH ROW
BEGIN
  IF OLD.status = 'approved' THEN -- Abort when trying to remove this record
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error. cannot delete a approved submission';
  END IF;
END
$$

DELIMITER ;

-- verify the trigger
SHOW TRIGGERS;


-- now grant prvillages to backend_dev user , only select insert update and delete
GRANT SELECT, INSERT, UPDATE, DELETE ON cms.countries TO 'backend_dev'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cms.roles TO 'backend_dev'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cms.subjects TO 'backend_dev'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cms.users TO 'backend_dev'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cms.role_user TO 'backend_dev'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cms.review_scores TO 'backend_dev'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cms.support_tickets TO 'backend_dev'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cms.conferences TO 'backend_dev'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cms.coupon_codes TO 'backend_dev'@'localhost';

-- first give delete permission on the submission table, and a before delete trigger will be used to stop deleting approved submissions
GRANT SELECT, INSERT, UPDATE, DELETE ON cms.submissions TO 'backend_dev'@'localhost';

-- dont give delete permissions for tickets table
GRANT SELECT, INSERT, UPDATE ON cms.tickets TO 'backend_dev'@'localhost';

-- grant permission to create view
GRANT CREATE VIEW ON cms.* TO 'backend_dev'@'localhost';

FLUSH PRIVILEGES;
-- check the permissions now
SHOW GRANTS FOR 'backend_dev'@'localhost';