create Database TDBS;
use TDBS;

-- 1. users --
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(50),
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_locked BOOLEAN DEFAULT FALSE
);
 use TDBS;
insert into users (  username , password_hash , email , phone_number ,role , status , last_login, is_locked)
values               ('John','johnabc','john@abc','12345678','work','active',now(),1);
                      

select * from users;

-- 2. user_roles --
CREATE TABLE user_roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    permissions_level INTEGER
);

insert into user_roles(role_name, description, permissions_level)
values('Admin', 'Has full access to all system features and settings', 10);
select * from user_roles;

-- 3. customers --
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(50),
    account_status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
insert into customers(first_name, last_name, email, phone_number, address, city, state, postal_code, country, account_status)
values ('Adiba', 'Parveen', 'adiba.parveen@example.com', '9876501234', '101 Rose Street', 'Delhi', 'Delhi', '110001', 'India', 'active');
select * from customers;

-- 4. customer_identity --
CREATE TABLE customer_identity (
    identity_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    document_type VARCHAR(50),
    document_number VARCHAR(100),
    issue_date DATE,
    expiry_date DATE,
    verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO customer_identity 
(customer_id, document_type, document_number, issue_date, expiry_date, verified)
VALUES
(1, 'Aadhaar Card', '1234-5678-9012', '2020-01-15', '2030-01-14', TRUE);
select * from customer_identity;

-- 5. plans --
CREATE TABLE plans (
    plan_id SERIAL PRIMARY KEY,
    plan_name VARCHAR(100),
    plan_type VARCHAR(50),
    price_monthly NUMERIC(10,2),
    data_limit_gb NUMERIC(10,2),
    voice_minutes INTEGER,
    sms_limit INTEGER,
    validity_days INTEGER,
    description TEXT,
    status VARCHAR(20)
);
INSERT INTO plans (plan_name, plan_type, price_monthly, data_limit_gb, voice_minutes, sms_limit, validity_days, description, status)
VALUES ('Super Saver Plan', 'Prepaid', 299.00, 50.00, 1000, 100, 28, 'Best value prepaid plan for data and calls', 'active');

-- 6. subscriptions --
CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    plan_id INTEGER REFERENCES plans(plan_id),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    auto_renew BOOLEAN DEFAULT FALSE,
    billing_cycle VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO subscriptions (customer_id, plan_id, start_date, end_date, status, auto_renew, billing_cycle)
VALUES (1, 1, '2025-06-01', '2025-06-29', 'active', TRUE, 'monthly');

-- 7. billing --
CREATE TABLE billing (
    bill_id SERIAL PRIMARY KEY,
    subscription_id INTEGER REFERENCES subscriptions(subscription_id),
    billing_date DATE,
    due_date DATE,
    total_amount NUMERIC(10,2),
    discount_amount NUMERIC(10,2),
    tax_amount NUMERIC(10,2),
    final_amount NUMERIC(10,2),
    payment_status VARCHAR(20),
    generated_by VARCHAR(50)
);
INSERT INTO billing (subscription_id, billing_date, due_date, total_amount, discount_amount, tax_amount, final_amount, payment_status, generated_by)
VALUES (1, '2025-06-01', '2025-06-05', 299.00, 20.00, 50.00, 329.00, 'unpaid', 'System');
-- 8. payments --
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    bill_id INTEGER REFERENCES billing(bill_id),
    customer_id INTEGER REFERENCES customers(customer_id),
    payment_date TIMESTAMP,
    payment_method VARCHAR(50),
    amount_paid NUMERIC(10,2),
    transaction_id VARCHAR(100),
    payment_status VARCHAR(20),
    verified BOOLEAN DEFAULT FALSE
);

INSERT INTO payments (bill_id, customer_id, payment_date, payment_method, amount_paid, transaction_id, payment_status, verified)
VALUES (1, 1, NOW(), 'UPI', 329.00, 'TXN123456789', 'successful', TRUE);
select * from payments;

-- 9. call_records --
CREATE TABLE call_records (
    call_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    caller_number VARCHAR(20),
    receiver_number VARCHAR(20),
    call_start_time TIMESTAMP,
    call_end_time TIMESTAMP,
    call_duration_sec INTEGER,
    call_type VARCHAR(20),
    location VARCHAR(100),
    charge NUMERIC(10,2)
);
INSERT INTO call_records (customer_id, caller_number, receiver_number, call_start_time, call_end_time, call_duration_sec, call_type, location, charge)
VALUES (1, '9876501234', '9876543210', NOW(), DATE_ADD(NOW(), INTERVAL 2 MINUTE), 120, 'outgoing', 'Delhi', 0.50);

select * from call_records;
-- 10. data_usage --


CREATE TABLE data_usage (
    data_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    session_start TIMESTAMP,
    session_end TIMESTAMP,
    data_used_mb NUMERIC(10,2),
    location VARCHAR(100),
    device_info TEXT,
    network_type VARCHAR(50)
);


INSERT INTO data_usage (customer_id, session_start, session_end, data_used_mb, location, device_info, network_type)
VALUES (1, NOW(), DATE_ADD(NOW(), INTERVAL 30 MINUTE), 450.00, 'Delhi', 'Samsung Galaxy M21, Android 11', '4G');


-- 11. sms_records --
CREATE TABLE sms_records (
    sms_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    sender_number VARCHAR(20),
    receiver_number VARCHAR(20),
    message_time TIMESTAMP,
    message_length INTEGER,
    status VARCHAR(20),
    charge NUMERIC(10,2)
);

INSERT INTO sms_records (customer_id, sender_number, receiver_number, message_time, message_length, status, charge)
VALUES (1, '9876501234', '9876543210', NOW(), 140, 'delivered', 0.25);
select * from sms_records;


-- 12. audit_logs --
CREATE TABLE audit_logs (
    log_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    activity_type VARCHAR(100),
    activity_time TIMESTAMP,
    ip_address VARCHAR(50),
    device_info TEXT,
    status VARCHAR(20),
    remarks TEXT
);
INSERT INTO audit_logs (user_id, activity_type, activity_time, ip_address, device_info, status, remarks)
VALUES (1, 'Login', NOW(), '192.168.1.1', 'Chrome on Windows', 'success', 'User logged in successfully');

select * from audit_logs;

-- 13. login_attempts--
CREATE TABLE login_attempts (
    attempt_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    attempt_time TIMESTAMP,
    ip_address VARCHAR(50),
    result VARCHAR(20),
    location VARCHAR(100)
);

INSERT INTO login_attempts (user_id, attempt_time, ip_address, result, location)
VALUES (1, NOW(), '192.168.1.1', 'success', 'Delhi');

select * from login_attempts;

-- 14. support_tickets --
CREATE TABLE support_tickets (
    ticket_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    issue_type VARCHAR(100),
    descriptions TEXT,
    status VARCHAR(20),
    priority VARCHAR(20),
    opened_at TIMESTAMP,
    resolved_at TIMESTAMP,
    assigned_to VARCHAR(100)
);

INSERT INTO support_tickets (customer_id, issue_type, descriptions, status, priority, opened_at, assigned_to)
VALUES                      (1, 'Network Issue', 'Frequent call drops in Delhi area', 'open', 'high', NOW(), 'Support Agent A');

select * from support_tickets;

-- 15. notifications --
CREATE TABLE notifications (
    notification_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    message TEXT,
    type VARCHAR(50),
    status VARCHAR(20),
    sent_at TIMESTAMP
);

INSERT INTO notifications (customer_id, message, type, status, sent_at)
VALUES                   (1, 'Your plan has been renewed successfully.', 'system', 'sent', NOW());
select * from notifications;

-- 16. devices --
CREATE TABLE devices (
    device_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    device_type VARCHAR(50),
    imei_number VARCHAR(50),
    manufacturer VARCHAR(50),
    os VARCHAR(50),
    os_version VARCHAR(50),
    activated_at TIMESTAMP,
    status VARCHAR(20)
);
  
  INSERT INTO devices (customer_id, device_type, imei_number, manufacturer, os, os_version, activated_at, status)
VALUES (1, 'Mobile', '860123456789012', 'Samsung', 'Android', '11', NOW(), 'active');

select * from devices;
  
-- 17. network_nodes --
CREATE TABLE network_nodes (
    node_id SERIAL PRIMARY KEY,
    node_name VARCHAR(100),
    location VARCHAR(100),
    ip_address VARCHAR(50),
    status VARCHAR(20),
    last_check_in TIMESTAMP,
    node_type VARCHAR(50)
);

INSERT INTO network_nodes (node_name, location, ip_address, status, last_check_in, node_type)
VALUES ('Node-Delhi-01', 'Delhi', '10.0.0.1', 'active', NOW(), '4G Tower');
select * from network_nodes;

-- 18. api_keys --
CREATE TABLE api_keys (
    key_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    api_key_hash TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    last_used TIMESTAMP,
    status VARCHAR(20)
);

INSERT INTO api_keys (user_id, api_key_hash, expires_at, last_used, status)
VALUES (1, 'a1b2c3d4e5f6g7h8i9j0', '2025-12-31 23:59:59', NOW(), 'active');

select * from api_keys;

-- 19. data_encryption_keys--
CREATE TABLE data_encryption_keys (
    key_id SERIAL PRIMARY KEY,
    key_label VARCHAR(100),
    encryption_type VARCHAR(50),
    created_at TIMESTAMP,
    expires_at TIMESTAMP,
    status VARCHAR(20),
    assigned_to_module VARCHAR(100)
);
INSERT INTO data_encryption_keys (key_label, encryption_type, created_at, expires_at, status, assigned_to_module)
VALUES ('Default Encryption Key', 'AES-256', NOW(), '2030-12-31', 'active', 'billing_module');

select * from data_encryption_keys;
-- 20. system_parameters--
CREATE TABLE system_parameters (
    parameter_id SERIAL PRIMARY KEY,
    param_key VARCHAR(100) UNIQUE NOT NULL,
    param_value TEXT,
    module_name VARCHAR(100),
    updated_at TIMESTAMP
);

INSERT INTO system_parameters (param_key, param_value, module_name, updated_at)
VALUES ('max_login_attempts', '5', 'authentication', NOW());
 select * from system_parameters;
 
 
 
