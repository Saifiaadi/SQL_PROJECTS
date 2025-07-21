create database DRDO;
Use DRDO;

-- 1. DRDO table--
create table drdo_labs(
Lab_ID int primary key auto_increment,
Lab_name Varchar(100),
Region_id int,
Address TEXT
);

desc drdo_labs;
alter table drdo_labs
change region region_id int;

-- 2. project Table --

 create table Lab_Projects(
 project_id int primary key auto_increment,
 lab_id int,
 project_name varchar(30),
 start_Date Date,
 End_Date date,
 status varchar (30),
 foreign key (Lab_id) references drdo_labs(Lab_id) 
 );
 
 -- 3. Scientists/Employees --
create table Lab_personnel (
 personnel_id int primary key auto_increment,
 lab_id int,
 Fullname varchar (30), 
 Designation varchar(30),
 join_date date,
 Email varchar(30),
 foreign key (lab_id) references drdo_labs (lab_id)
 );
   
 -- 4.  mission --
  create table mission_status(
  mission_id int primary key auto_increment,
  mission_name varchar(30),
  Status varchar(30),
  start_date date,
  completion_date date
  );
  
  -- 5. Lab_funding --
  create table lab_funding(
  funding_Id int primary key auto_increment,
  lab_id int,
  project_id int,
  amount decimal (10,2),
  funding_date date,
  foreign key (lab_id) references drdo_labs (lab_id),
  foreign key (project_id) references lab_projects(project_id)
  );
  
  
  -- 6. Region--
   Create table Region(
   Region_ID int primary key auto_increment,
   Region_name varchar(30)
   );
   
  
  -- 7. lab_performance_metrics --
   create table lab_performance_metrics (
   performance_id int primary key auto_increment,
   Lab_id int,
   mission_success_rate DECIMAL(5,2),
   readiness_score DECIMAL(5,2),
    evaluated_on DATE,
    FOREIGN KEY (lab_id) REFERENCES drdo_labs(lab_id)
);

-- 8. Lab inventory--
create table lab_inventory(
  inventory_id int primary key auto_increment,
  lab_id int,
  Item_name varchar(30),
  quantity int,
  last_updated date
);
  
  -- 9. lab mission map--
  create table lab_mission_map(
  map_id int primary key auto_increment,
  lab_id int,
  mission_id int,
  role_in_mission varchar(30),
  foreign key (lab_id) references drdo_labs (lab_id),
  foreign key (mission_id) references mission_status (mission_id)
  );
  desc lab_mission_map;
  select * from lab_mission_map;
  
  -- 10. Training Programs--
CREATE TABLE training_programs (
    training_id INT PRIMARY KEY AUTO_INCREMENT,
    lab_id INT,
    topic VARCHAR(150),
    trainer_name VARCHAR(100),
    date_conducted DATE,
    FOREIGN KEY (lab_id) REFERENCES drdo_labs(lab_id)
);


-- 11. Updates & Logs--
CREATE TABLE lab_update_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    lab_id INT,
    update_type VARCHAR(100),
    description TEXT,
    update_date DATE,
    FOREIGN KEY (lab_id) REFERENCES drdo_labs(lab_id)
);

-- 12. Attendance Tracking--
CREATE TABLE personnel_attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    personnel_id INT,
    attendance_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (personnel_id) REFERENCES lab_personnel(personnel_id)
);

 -- 13. Publications
CREATE TABLE research_publications (
    publication_id INT PRIMARY KEY AUTO_INCREMENT,
    personnel_id INT,
    title VARCHAR(200),
    publish_date DATE,
    journal_name VARCHAR(150),
    FOREIGN KEY (personnel_id) REFERENCES lab_personnel(personnel_id)
);

-- 14. Lab Infrastructure
CREATE TABLE lab_facilities (
    facility_id INT PRIMARY KEY AUTO_INCREMENT,
    lab_id INT,
    facility_type VARCHAR(100),
    description TEXT,
    FOREIGN KEY (lab_id) REFERENCES drdo_labs(lab_id)
);


-- 15. Emergency Response
CREATE TABLE emergency_protocols (
    protocol_id INT PRIMARY KEY AUTO_INCREMENT,
    lab_id INT,
    drill_type VARCHAR(100),
    protocol_details TEXT,
    last_drill_date DATE,
    FOREIGN KEY (lab_id) REFERENCES drdo_labs(lab_id)
); 

INSERT INTO region(region_name) values
('North'),('South'),('East'),('West');


INSERT INTO drdo_labs (lab_name, region_id, address) VALUES 
('DRDL Hyderabad', 1, 'Hyderabad, Telangana'),
('R&DE Pune', 2, 'Pune, Maharashtra'),
('R&DE Gujrat', 3, 'Gujrat, Maharashtra'),
('DRDO Delhi HQ', 1, 'Delhi'),
('DFRL Mysuru', 2, 'Mysuru, Karnataka');
 
 update drdo_labs
 set address ='new delhi, delhi'
 where lab_id= 4;

select * from drdo_labs;

INSERT INTO lab_personnel (lab_id, Fullname, designation, join_date, email) VALUES 
(1, 'Dr. A. Reddy', 'Scientist-F', '2018-06-01', 'areddy@drdo.gov.in'),
(2, 'Ms. R. Nair', 'Scientist-D', '2020-03-15', 'rnair@drdo.gov.in'),
(3, 'Mr. K. Sharma', 'Technician', '2019-08-10', 'ksharma@drdo.gov.in'),
(4, 'Dr. Meera Das', 'Scientist-E', '2021-11-25', 'mdas@drdo.gov.in'),
(5, 'Dr. Sanjeev Gaur', 'researchers', '2024-12-06','sg@drdo.gov.in'),
(2, 'Dr. AB. Reddy', 'Scientist-F', '2017-06-01', 'abreddy@drdo.gov.in'),
(1, 'Ms. RC. Nair', 'Scientist-D', '2020-03-15', 'rcnair@drdo.gov.in'),
(1, 'Mr. KG. Sharma', 'Technician', '2020-08-10', 'kgsharma@drdo.gov.in'),
(1, 'Dr. PMeera Das', 'Scientist-E', '2023-11-25', 'Pmdas@drdo.gov.in'),
(1, 'Dr. Ranjeev Gaur', 'researchers', '2025-02-06','rg@drdo.gov.in');


select * from lab_personnel;
  
INSERT INTO lab_projects (lab_id, project_name, start_date, end_date, status) VALUES 
(1, 'Missile Control System', '2021-01-15', NULL, 'Active'),
(2, 'Robotics for Defence', '2020-05-20', '2023-03-10', 'Completed'),
(3, 'AI Surveillance', '2022-09-01', NULL, 'Active'),
(4, 'Prithvi Series', '2023-01-05', NULL,'On-Going'),
(1, 'Missile Control System 2', '2022-01-15', NULL, 'Active'),
(2, 'Robotics for Defence 2', '2021-05-20', '2023-03-10', 'Completed'),
(3, 'AI Surveillance 2', '2020-09-01', NULL, 'Active'),
(4, 'Prithvi Series 2', '2024-01-05', NULL,'On-Going'),
(1, 'Missile Control System 3', '2021-01-15', NULL, 'Active'),
(2, 'Robotics for Defence 3', '2020-05-20', '2023-03-10', 'Completed'),
(3, 'AI Surveillance 3', '2022-09-01', NULL, 'Active'),
(4, 'Prithvi Series 3', '2023-01-05', NULL,'On-Going'),
(1, 'Missile Control System 4', '2021-01-15', NULL, 'Active'),
(2, 'Robotics for Defence 5', '2020-05-20', '2023-03-10', 'Completed'),
(3, 'AI Surveillance 6', '2022-09-01', NULL, 'Active'),
(4, 'Prithvi Series 7', '2023-01-05', NULL,'On-Going');
  
select * from lab_projects;

INSERT INTO mission_status (mission_id,mission_name, status, start_date, completion_date) VALUES 
('Agni-V Test Mission', 'Completed', '2022-03-01', '2022-03-10'),
('High Altitude UAV Trial', 'Active', '2023-07-01', NULL),
(5, 'Hypersonic Glide Test', 'Completed', '2024-02-10', '2024-03-05'),
(6, 'Integrated Sensor Trials', 'Active', '2024-06-01', NULL),
(7, 'Ballistic Interceptor Mission', 'Completed', '2023-09-10', '2023-09-18'),
(8, 'AI Drone Swarm Trial', 'Completed', '2024-04-01', '2024-04-12'),
(9, 'Secure Satcom Deployment', 'Active', '2025-01-10', NULL);

select * from mission_status;

INSERT INTO lab_funding (lab_id, project_id, amount, funding_date) VALUES 
(1, 1, 50000000.00, '2022-01-10'),
(2, 2, 25000000.00, '2021-02-15'),
(3, 3, 45000000.00, '2023-09-20'),
(1, 1, 12000000.00, '2023-01-12'),     -- DRDL Hyderabad, Missile Control System
(2, 2, 8000000.00, '2022-06-20'),      -- R&DE Pune, Robotics for Defence
(3, 3, 15000000.00, '2024-05-10'),     -- R&DE Gujarat, AI Surveillance
(4, 4, 6000000.00, '2024-09-18'),      -- DRDO Delhi HQ, Prithvi Series
(5, 5, 20000000.00, '2024-11-25'),     -- DFRL Mysuru, Quantum Communication Link
(1, 6, 17500000.00, '2023-12-01'),     -- DRDL Hyderabad, Advanced Radar Systems
(4, 7, 9000000.00, '2025-02-15');      -- DRDO Delhi HQ, Secure Satellite Protocols

select * from lab_funding;

INSERT INTO lab_performance_metrics (lab_id, mission_success_rate, readiness_score, evaluated_on) VALUES 
(1, 95.50, 90.00, '2024-03-31'),
(2, 89.00, 87.50, '2024-03-31'),
(3, 93.75, 91.00, '2024-03-31'),
(4, 88.40, 83.20, '2024-06-30'),  -- DRDO Delhi HQ
(5, 92.75, 89.50, '2024-06-30'),  -- DFRL Mysuru
(1, 90.00, 86.00, '2023-12-31'),  -- DRDL Hyderabad
(2, 85.20, 80.00, '2023-12-31'),  -- R&DE Pune
(3, 94.30, 91.80, '2024-05-15'),  -- R&DE Gujarat
(4, 89.60, 87.40, '2023-11-10'),  -- DRDO Delhi HQ
(5, 95.10, 92.30, '2023-10-01');  -- DFRL Mysuru

select * from lab_performance_metrics;

INSERT INTO lab_inventory (lab_id, item_name, quantity, last_updated) VALUES 
(1, 'Radar Unit', 12, '2024-06-01'),
(2, 'Robotic Arm V2', 5, '2024-05-15'),
(3, 'Thermal Camera', 20, '2024-06-10');

select * from lab_inventory;

INSERT INTO lab_mission_map (lab_id, mission_id, role_in_mission) VALUES
(1, 2, 'Telemetry Design'),
(1, 3, 'Launch Control Software'),
(1, 4, 'Propulsion Analysis'),
(1, 5, 'Flight Computer Development'),
(1, 6, 'Target Acquisition System'),
(1, 7, 'Radar Communication System'),
(1, 8, 'Missile Tracking Logic'),
(1, 9, 'Final Assembly QA'),
(2, 1, 'Payload Integration'),
(2, 3, 'UAV Navigation'),
(2, 4, 'Sensor Calibration'),
(2, 5, 'Mobility Testing'),
(2, 6, 'Autonomous Control'),
(2, 7, 'Power Efficiency Enhancement'),
(2, 8, 'Range Optimization'),
(2, 9, 'Terrain Mapping'),
(3, 1, 'Data Encryption'),
(3, 3, 'AI Targeting Integration'),
(3, 4, 'Deep Learning Model Training'),
(3, 5, 'Communication Protocols'),
(3, 6, 'Cloud Integration'),
(3, 7, 'Real-Time Analysis Module'),
(3, 8, 'Object Detection Tuning'),
(3, 9, 'Interface with Defense Grid'),
(4, 1, 'Chemical Testing Unit'),
(4, 2, 'Life Support Systems'),
(4, 3, 'Environmental Simulation Lab');

select * from lab_mission_map;
truncate lab_mission_map;

INSERT INTO training_programs (lab_id, topic, trainer_name, date_conducted) VALUES 
(1, 'Advanced Missile Simulation', 'Dr. V. Rao', '2023-12-01'),
(2, 'Robotics for Tactical Use', 'Prof. G. Menon', '2024-01-15');

select * from training_programs;

INSERT INTO lab_update_logs (lab_id, update_type, description, update_date) VALUES 
(1, 'Funding Update', 'Received 5Cr for new missile tech.', '2024-02-01'),
(2, 'Performance Review', 'Lab ranked among top 3.', '2024-03-01'),
(3, 'Infrastructure Upgrade', 'Installed new AI simulation lab.', '2024-04-10'),
(4, 'Safety Audit', 'Completed annual fire and electrical safety audit.', '2025-06-05'),
(5, 'System Upgrade', 'Deployed quantum encryption protocol.', '2025-06-12'),
(1, 'Mission Debrief', 'Completed review of Agni-V mission phase.', '2025-05-20'),
(2, 'New Project Initiated', 'Started autonomous vehicle integration project.', '2025-06-18'),
(3, 'Equipment Maintenance', 'Serviced radar and telemetry units.', '2025-06-22'),
(4, 'Security Review', 'Cybersecurity protocols updated post assessment.', '2025-05-30');

select * from lab_update_logs;

INSERT INTO personnel_attendance (personnel_id, attendance_date, status) VALUES 
(1, '2024-06-24', 'Present'),
(2, '2024-06-24', 'Present'),
(3, '2024-06-24', 'Absent');

select * from personnel_attendance;

INSERT INTO research_publications (personnel_id, title, publish_date, journal_name) VALUES 
(1, 'Guidance System Optimization', '2023-08-10', 'Defence Tech Journal'),
(2, 'Robotics for Army Mobility', '2023-10-05', 'AI & Defence');

select * from research_publications;

INSERT INTO lab_facilities (lab_id, facility_type, description) VALUES 
(1, 'Wind Tunnel', 'Used for aerodynamic testing'),
(2, 'Robotics Lab', 'Fully equipped AI robotic lab');

select * from lab_facilities;

INSERT INTO emergency_protocols (lab_id, drill_type, protocol_details, last_drill_date) VALUES 
(1, 'Fire Drill', 'Evacuation and shutdown procedures', '2024-04-10'),
(3, 'Cybersecurity Drill', 'Red team vs blue team test', '2024-05-12'); 

select * from emergency_protocols;
 
 
 ----------------------------------------------------------------------------------------------
 
 -- Show all data where region is "North"
 select dl.* , r.region_name
 from drdo_labs dl
 join region r on dl.region_id = r.region_id
  where r.region_name = 'north';

-- Show all labs that have more than 5 scientists.   

SELECT dl.lab_id, dl.lab_name, COUNT(lp.personnel_id) AS scientist_count, GROUP_CONCAT(lp.fullname SEPARATOR ', ') AS scientist_names
FROM drdo_labs dl
JOIN lab_personnel lp ON dl.lab_id = lp.lab_id
GROUP BY dl.lab_id, dl.lab_name
HAVING COUNT(lp.personnel_id) >= 5;
  
  
 
 
