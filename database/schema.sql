CREATE DATABASE IF NOT EXISTS payroll_system;
USE payroll_system;

CREATE TABLE department (
  dept_id INT AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE employee (
  emp_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(15),
  designation VARCHAR(50),
  dept_id INT,
  join_date DATE,
  bank_account VARCHAR(30),
  status ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE salary_structure (
  emp_id INT PRIMARY KEY,
  basic DECIMAL(10,2) NOT NULL,
  hra_percent DECIMAL(5,2) DEFAULT 40,
  da_percent DECIMAL(5,2) DEFAULT 10,
  other_allowance DECIMAL(10,2) DEFAULT 0,
  pf_percent DECIMAL(5,2) DEFAULT 12,
  tax_percent DECIMAL(5,2) DEFAULT 0,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

CREATE TABLE attendance (
  id INT AUTO_INCREMENT PRIMARY KEY,
  emp_id INT,
  month TINYINT,
  year SMALLINT,
  working_days TINYINT,
  present_days TINYINT,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

CREATE TABLE payroll (
  payroll_id INT AUTO_INCREMENT PRIMARY KEY,
  emp_id INT,
  month TINYINT,
  year SMALLINT,
  gross DECIMAL(10,2),
  total_deductions DECIMAL(10,2),
  net_salary DECIMAL(10,2),
  generated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (emp_id, month, year),
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE,
  password_hash VARCHAR(255),
  role ENUM('ADMIN','EMPLOYEE'),
  emp_id INT NULL,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);