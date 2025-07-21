create database finance;

use Finance;


create table customer(
Customer_id integer auto_increment primary key,
Full_Name VARCHAR(100) NOT NULL,
Contact_Number integer,
EmailID varchar(30),
Date_Of_Birth DATE,
PAN VARCHAR(10),
Aadhaar VARCHAR(12)
);

create table Accounts(
Account_id integer auto_increment primary key,
customer_id integer,
Account_no integer unique not null,
Account_type varchar(20),
IFSC_code varchar(30),
Balance decimal(20,0) default 0.00,
foreign key (customer_id) references customer (customer_id)
 );
 
create table Transaction1(
Transaction_id int auto_increment primary key,
Account_id int,
transaction_type varchar(20),
amount decimal(20,0),
Decsription varchar(255),
foreign key (account_id) references Accounts (account_id) 
);

create Table loan (
Loan_id integer auto_increment primary key,
customer_id integer,
loan_type varchar(20),
loan_amount decimal(10,2),
foreign key (customer_id) references customer(customer_id)
);

create table credit_table(
Card_id int auto_increment primary key,
customer_id integer,
Card_type varchar(10),
card_number integer,
Expiry_date date,
CVV int,
foreign key (customer_id) references customer(customer_id)
);

Alter Table credit_table modify column card_number  varchar (20);           -- here i am not able to use ALTER column--

desc credit_table;
desc loan;
desc accounts;
desc transaction1;
desc Customer;


-- Inserting values --

Insert into customer (Full_Name ,Contact_Number,EmailID ,Date_Of_Birth ,PAN,Aadhaar)
values 
       ( '101','Adiba','12345678', 'adibasaifi859@gmail.com', '1999-04-01', 'eutpp3980e', '111122223333'),
	   ( '102','Eliph','12345679', 'aeliphsaifi859@gmail.com', '1999-04-01', 'eutpp3980G', '211122223333'),
       ('Eliph','12345679', 'aeliphsaifi859@gmail.com', '1999-04-01', 'Autpp3980G', '211122223334');
       
       select * from customer;
       
       insert into Accounts (customer_id,Account_no ,Account_type,IFSC_code ,Balance ) 
       values 
              ('101','11111','saving','123abc','50000'),
              ('102','22222','saving','123abc','50000'),
              ('103','33333','saving','123abc','50000');
              
       select * from Accounts;
       
       insert into transaction1 (Account_id,transaction_type,amount,Decsription)
       values 
              ('1','debit','23000','paymentdone'),    
              ('6','credit','12000','paymentdone');
              
        select * from transaction1;      
        
      insert into loan (customer_id ,loan_type , loan_amount )    
      values
              ('101','Home','5000000'),
              ('102','Education','8000000');
              
               select * from loan;
               
	  insert into credit_table(customer_id, Card_type,card_number,Expiry_date,CVV)
      values
            ('101','credit','112233445566','2025-12-01','131'),
            ('102','debit','665544332211','2025-10-01','121');
            desc credit_table;
            
                   select * from credit_table;
               
              