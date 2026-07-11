SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;

SET
    @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS,
    FOREIGN_KEY_CHECKS = 0;

SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL';

DROP SCHEMA IF EXISTS `event_organizer`;

CREATE SCHEMA IF NOT EXISTS `event_organizer`;

USE `event_organizer`;

-- -----------------------------------------------------
-- Table clients
-- -----------------------------------------------------
CREATE TABLE clients (
    id INT NOT NULL AUTO_INCREMENT,
    client_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    company VARCHAR(100),
    PRIMARY KEY (id),
    INDEX (client_name),
    INDEX (email)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table employees
-- -----------------------------------------------------
CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    position VARCHAR(50),
    salary DECIMAL(12, 2),
    PRIMARY KEY (id),
    INDEX (email)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table event_types
-- -----------------------------------------------------
CREATE TABLE event_types (
    id INT NOT NULL AUTO_INCREMENT,
    type_name VARCHAR(100),
    description TEXT,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table venues
-- -----------------------------------------------------
CREATE TABLE venues (
    id INT NOT NULL AUTO_INCREMENT,
    venue_name VARCHAR(150),
    address TEXT,
    city VARCHAR(50),
    capacity INT,
    price_per_day DECIMAL(12, 2),
    PRIMARY KEY (id),
    INDEX (city)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table events
-- -----------------------------------------------------
CREATE TABLE events (
    id INT NOT NULL AUTO_INCREMENT,
    event_name VARCHAR(150),
    event_type_id INT,
    client_id INT,
    venue_id INT,
    event_date DATE,
    start_time TIME,
    end_time TIME,
    budget DECIMAL(15, 2),
    status VARCHAR(50),
    PRIMARY KEY (id),
    INDEX (client_id),
    INDEX (venue_id),
    INDEX (event_type_id),
    CONSTRAINT fk_events_clients FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_events_venue FOREIGN KEY (venue_id) REFERENCES venues (id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_events_type FOREIGN KEY (event_type_id) REFERENCES event_types (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table event_staff
-- -----------------------------------------------------
CREATE TABLE event_staff (
    event_id INT NOT NULL,
    employee_id INT NOT NULL,
    role VARCHAR(50),
    PRIMARY KEY (event_id, employee_id),
    INDEX (employee_id),
    CONSTRAINT fk_event_staff_event FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_event_staff_employee FOREIGN KEY (employee_id) REFERENCES employees (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table vendors
-- -----------------------------------------------------
CREATE TABLE vendors (
    id INT NOT NULL AUTO_INCREMENT,
    vendor_name VARCHAR(150),
    service_type VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    price DECIMAL(12, 2),
    PRIMARY KEY (id)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table event_vendors
-- -----------------------------------------------------
CREATE TABLE event_vendors (
    event_id INT NOT NULL,
    vendor_id INT NOT NULL,
    service_cost DECIMAL(12, 2),
    PRIMARY KEY (event_id, vendor_id),
    INDEX (vendor_id),
    CONSTRAINT fk_event_vendor_event FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_event_vendor_vendor FOREIGN KEY (vendor_id) REFERENCES vendors (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table payments
-- -----------------------------------------------------
CREATE TABLE payments (
    id INT NOT NULL AUTO_INCREMENT,
    event_id INT,
    payment_date DATE,
    amount DECIMAL(15, 2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    PRIMARY KEY (id),
    INDEX (event_id),
    CONSTRAINT fk_payment_event FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table tickets
-- -----------------------------------------------------
CREATE TABLE tickets (
    id INT NOT NULL AUTO_INCREMENT,
    event_id INT,
    ticket_type VARCHAR(50),
    price DECIMAL(10, 2),
    quantity INT,
    PRIMARY KEY (id),
    INDEX (event_id),
    CONSTRAINT fk_ticket_event FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table attendees
-- -----------------------------------------------------
CREATE TABLE attendees (
    id INT NOT NULL AUTO_INCREMENT,
    event_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    PRIMARY KEY (id),
    INDEX (event_id),
    CONSTRAINT fk_attendees_event FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

SET SQL_MODE = @OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;