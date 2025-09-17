CREATE DATABASE clinicBookingSystem;

USE clinicBookingSystem;

-- Specialties (e.g., Cardiology, Pediatrics)
CREATE TABLE Expertise (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE,
description TEXT
);

-- Doctors
CREATE TABLE Doctors (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE,
phone VARCHAR(30),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Many-to-many: doctors <-> expertise
CREATE TABLE doctor_expertise (
doctor_id INT NOT NULL,
expertise_id INT NOT NULL,
PRIMARY KEY (doctor_id, expertise_id),
CONSTRAINT fk_ds_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_ds_expertise FOREIGN KEY (expertise_id) REFERENCES Expertise(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Patients
CREATE TABLE patients (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE,
phone VARCHAR(30),
date_of_birth DATE,
gender ENUM('male','female','other') DEFAULT 'other',
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Services offered (e.g., Consultation, Follow-up, Vaccination)
CREATE TABLE services (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(150) NOT NULL UNIQUE,
duration_minutes INT NOT NULL DEFAULT 30,
price DECIMAL(10,2) DEFAULT 0.00
);

-- Rooms
CREATE TABLE rooms (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE,
location VARCHAR(255)
);

-- Appointments
CREATE TABLE appointments (
id INT AUTO_INCREMENT PRIMARY KEY,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
service_id INT NOT NULL,
room_id INT,
start_time DATETIME NOT NULL,
end_time DATETIME NOT NULL,
status ENUM('scheduled','checked_in','completed','cancelled','no_show_up') DEFAULT 'scheduled',
notes TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT fk_appt_patient FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
CONSTRAINT fk_appt_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(id) ON DELETE CASCADE,
CONSTRAINT fk_appt_service FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE RESTRICT,
CONSTRAINT fk_appt_room FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE SET NULL
);

-- Prevent double-booking Of appointments: 
CREATE UNIQUE INDEX index_doctor_start_time ON appointments (doctor_id, start_time);

-- Preventing same patient booking same doctor at the same time
CREATE UNIQUE INDEX index_patient_doctor_start ON appointments (patient_id, doctor_id, start_time);

-- -- Prescription table (linked to appointment)
CREATE TABLE prescriptions (
id INT AUTO_INCREMENT PRIMARY KEY,
appointment_id INT NOT NULL,
medication TEXT NOT NULL,
instructions TEXT,
prescribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_presc_appt FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE
);

-- -- Payments
CREATE TABLE payments (
id INT AUTO_INCREMENT PRIMARY KEY,
appointment_id INT NOT NULL,
amount DECIMAL(10,2) NOT NULL,
method ENUM('cash','card','mobile_money','insurance') DEFAULT 'cash',
paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_payment_appt FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE
);


-- Listing or showing tables in the database
SHOW TABLES;