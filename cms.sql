
drop database if exists cms;
create database cms;
use cms;

CREATE TABLE IF NOT EXISTS countries (
    code VARCHAR(50) NOT NULL PRIMARY KEY,
    name LONGTEXT NOT NULL,
    flag VARCHAR(30) NOT NULL,
    createdAt timestamp default current_timestamp,
    updatedAt timestamp
);

CREATE TABLE IF NOT EXISTS roles (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name ENUM("Author","Reviewer","SuperAdmin","Admin"),
    description VARCHAR(100),
    createdAt timestamp default current_timestamp,
    updatedAt timestamp
);

CREATE TABLE IF NOT EXISTS subjects (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    description VARCHAR(150),
    createdAt timestamp default current_timestamp,
    updatedAt timestamp
);

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30),
    email VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    country_code VARCHAR(50) NOT NULL,
    createdAt timestamp default current_timestamp,
    updatedAt timestamp,
    FOREIGN KEY (country_code) REFERENCES countries(code)
);

CREATE TABLE IF NOT EXISTS role_user (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    createdAt timestamp default current_timestamp,
    updatedAt timestamp,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS submissions (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    subject_id INT NOT NULL,
    title VARCHAR(255),
    -- type VARCHAR(20),
    co_authors JSON default NULL,
    status ENUM('pending', 'approved', 'rejected'),
    file VARCHAR(255),
    createdAt timestamp default current_timestamp,
    updatedAt timestamp,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

CREATE TABLE IF NOT EXISTS review_scores (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    submission_id INT NOT NULL,
    completeness DECIMAL(2,1),
    subject_knowledge DECIMAL(2,1),
    comments VARCHAR(150),
    createdAt timestamp default current_timestamp,
    updatedAt timestamp,
    FOREIGN KEY (submission_id) REFERENCES submissions(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS support_tickets (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    message VARCHAR(500),
    status ENUM('pending', 'inprogress', 'completed'),
    createdAt timestamp default current_timestamp,
    updatedAt timestamp,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS conferences (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(500) NOT NULL,
    description LONGTEXT,
    date DATE,
    venue VARCHAR(50),
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    createdAt timestamp default current_timestamp,
    updatedAt timestamp
);


CREATE TABLE IF NOT EXISTS coupon_codes (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    conference_id INT NOT NULL,
    vendor VARCHAR(50) NOT NULL,
    coupon_code VARCHAR(10) NOT NULL UNIQUE,
    discount DECIMAL(3.1),
    createdAt timestamp default current_timestamp,
    updatedAt timestamp,
    FOREIGN KEY (conference_id) REFERENCES conferences(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tickets (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    conference_id INT NOT NULL,
    coupon_code VARCHAR(10),
    type ENUM('General-admission', 'VIP', 'Reserved-Seating', 'Early-bird-discount', 'Coded-discount'),
    price DECIMAL(10,2),
    createdAt timestamp default current_timestamp,
    updatedAt timestamp,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (conference_id) REFERENCES conferences(id),
    FOREIGN KEY (coupon_code) REFERENCES coupon_codes(coupon_code)
);
