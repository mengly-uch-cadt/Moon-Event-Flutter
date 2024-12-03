-- Create Database
CREATE DATABASE event_management_system;

USE event_management_system;

-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Auto-incrementing integer ID
    uuid CHAR(36) UNIQUE NOT NULL,  -- UUID as a second identifier
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    profile_picture_url VARCHAR(255),
    bio TEXT,
    notifications_enabled INT DEFAULT 1  -- Removed the trailing comma
);

-- Events Table
CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Auto-incrementing integer ID
    uuid CHAR(36) UNIQUE NOT NULL,  -- UUID as a second identifier
    title VARCHAR(255) NOT NULL,
    description TEXT,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    address VARCHAR(255),
    latitude DOUBLE,
    longitude DOUBLE,
    image_url VARCHAR(255),
    organizer_id INT,  -- Integer ID of the organizer (references users)
    is_public INT DEFAULT 1,
    category VARCHAR(255),
    FOREIGN KEY (organizer_id) REFERENCES users(id)
);

-- Join Table for Users and Events (many-to-many relationship)
CREATE TABLE user_events (
    event_uuid CHAR(36),  -- Fixed data type to CHAR(36)
    user_uuid CHAR(36),   -- Fixed data type to CHAR(36)
    PRIMARY KEY (event_uuid, user_uuid),
    FOREIGN KEY (event_uuid) REFERENCES events(uuid),
    FOREIGN KEY (user_uuid) REFERENCES users(uuid)
);

-- Notifications Table
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Auto-incrementing integer ID
    uuid CHAR(36) UNIQUE NOT NULL,  -- UUID as a second identifier
    user_id INT,  -- Integer ID reference to users table
    message TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    event_id INT,  -- Integer ID reference to events table
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (event_id) REFERENCES events(id)
);

-- Categories Table
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Auto-incrementing integer ID
    uuid CHAR(36) UNIQUE NOT NULL,  -- UUID as a second identifier
    name VARCHAR(255) NOT NULL,
    icon VARCHAR(255)
);