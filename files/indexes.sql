-- here we create the neccessary indexes on the tables required
-- now this has to be run as root or db_admin since backend_dev doesnt have permission to create indexes

-- on users table
CREATE INDEX idx_firstname ON users (first_name);
CREATE INDEX idx_lastname ON users (last_name);

-- on submission table
CREATE INDEX idx_title ON submissions (title);
