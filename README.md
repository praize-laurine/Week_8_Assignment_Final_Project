# Clinic Booking System – Database Design (MySQL)

- This project implements a relational database schema for a Clinic Booking System using MySQL.
The design enforces data integrity through constraints, relationships, and indexes, making it suitable for managing patients, doctors, appointments, prescriptions, and payments in a real-world clinic.

## Features

- Structured relational schema with 7 main entities

- Proper constraints: PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE

*Relationships:*

- One-to-Many (Patients → Appointments, Doctors → Appointments)

- One-to-Many (Appointments → Prescriptions, Appointments → Payments)

- One-to-Many (Services → Appointments, Rooms → Appointments)

- Indexes to prevent double-booking of doctors and patients

- Foreign key rules (CASCADE, SET NULL, RESTRICT) for safe data handling

### Database Schema
*Tables*

- Patients → Stores patient details

- Doctors → Stores doctor details and specialties

- Services → Medical services offered (consultation, lab tests, etc.)

- Rooms → Clinic rooms (consultation rooms, labs, wards)

- Appointments → Links patients, doctors, services, and rooms

- Prescriptions → Medications linked to appointments

- Payments → Payment records linked to appointments


#### Constraints
- Foreign keys with cascade rules
- Unique indexes to prevent double-booking



# Getting Started

1. Run the SQL command: `CREATE DATABASE clinicBookingSystem;`
2. Importthe Schema: `mysql -u root -p clinicBookingSystem < schema.sql`
3. Verify Tables: 
`USE clinicBookingSystem;`

`SHOW TABLES;`
