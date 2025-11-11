
CREATE DATABASE IF NOT EXISTS goldencrop_db;
USE goldencrop_db;
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL, 
    contact VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS branch (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL, 
    location VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS produce (
    produce_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL, 
    selling_price DECIMAL(10, 2) NOT NULL 
);

CREATE TABLE IF NOT EXISTS dealer (
    dealer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    contact VARCHAR(50) NOT NULL,
    location VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS buyer (
    buyer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    contact VARCHAR(50) NOT NULL,
    national_id VARCHAR(50) UNIQUE, 
);

CREATE TABLE IF NOT EXISTS procurement (
    proc_id INT AUTO_INCREMENT PRIMARY KEY,
    produce_id INT NOT NULL,
    tonnage DECIMAL(10, 2) NOT NULL,
    cost DECIMAL(12, 2) NOT NULL, 
    dealer_id INT NOT NULL,
    branch_id INT NOT NULL,
    recorded_by INT NOT NULL, 
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (produce_id) REFERENCES produce(produce_id),
    FOREIGN KEY (dealer_id) REFERENCES dealer(dealer_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    FOREIGN KEY (recorded_by) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    produce_id INT NOT NULL,
    tonnage DECIMAL(10, 2) NOT NULL,
    amount_paid DECIMAL(12, 2) NOT NULL,
    buyer_id INT NOT NULL,
    sales_agent_id INT NOT NULL,
    branch_id INT NOT NULL,
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (produce_id) REFERENCES produce(produce_id),
    FOREIGN KEY (buyer_id) REFERENCES buyer(buyer_id),
    FOREIGN KEY (sales_agent_id) REFERENCES users(user_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

CREATE TABLE IF NOT EXISTS credit_sale (
    credit_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT UNIQUE NOT NULL, 
    amount_due DECIMAL(12, 2) NOT NULL,
    due_date DATE NOT NULL,
    is_settled BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
);

CREATE TABLE IF NOT EXISTS stock (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    produce_id INT NOT NULL,
    branch_id INT NOT NULL,
    current_tonnage DECIMAL(10, 2) NOT NULL,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE (produce_id, branch_id), 

    FOREIGN KEY (produce_id) REFERENCES produce(produce_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

