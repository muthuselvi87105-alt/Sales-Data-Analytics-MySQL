create database sales_data_analyst
use sales_data_analyst

create table categories (
    category_id int primary key auto_increment,
    category_name varchar(100) not null,
    description varchar(255)
);

create table suppliers (
    supplier_id int primary key,
    supplier_name varchar(100) not null,
    contact_person varchar(100),
    phone varchar(15),
    email varchar(100),
    city varchar(100));

create table customers (
    customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    gender varchar(10),
    age int,
    phone varchar(15),
    email varchar(100),
    city varchar(100),
    state varchar(100),
    created_date date
);
create table branches (
    branch_id int primary key auto_increment,
    branch_name varchar(100) not null,
    city varchar(100),
    state varchar(100)
);

create table managers (manager_id int primary key auto_increment,manager_name varchar(100) not null,
    salary decimal(10,2),
    phone varchar(15),
    email varchar(100),
    branch_id int,
    foreign key(branch_id) references branches(branch_id)
);

create table employees (
    employee_id int primary key auto_increment,
    employee_name varchar(100) not null,
    role varchar(50),
    salary decimal(10,2),
    phone varchar(15),
    email varchar(100),
    branch_id int,
    manager_id int,
    hire_date date,
    foreign key (branch_id) references branches(branch_id),
    foreign key (manager_id) references managers(manager_id)
);

create table products (
    product_id int primary key auto_increment,
    product_name varchar(100) not null,
    category_id int,
    brand varchar(100),
    cost_price decimal(10,2),
    selling_price decimal(10,2),
    barcode varchar(50),
    created_date DATE,
    foreign key (category_id) references categories(category_id)
);
	create table inventory (
    inventory_id int primary key auto_increment,
    product_id int,
    stock_quantity int,
    reorder_level int,
    last_updated date,
    foreign key (product_id) references products(product_id)
);

create table purchases (purchase_id int primary key auto_increment,supplier_id int,
    purchase_date date,
    total_amount decimal,
    status varchar(50),
    foreign key (supplier_id) references suppliers(supplier_id)
);

create table purchase_details (
    purchase_detail_id int primary key auto_increment,
    purchase_id int,
    product_id int,
    quantity int,
    purchase_price decimal,
    subtotal decimal,
    foreign key (purchase_id) references purchases(purchase_id),
	foreign key (product_id) references products(product_id)
);

create table sales (sale_id int primary key auto_increment,customer_id int,sale_date date,
    total_amount decimal,
    discount decimal,
    final_amount decimal,
    payment_status varchar(50),
    foreign key (customer_id) references customers(customer_id)
);

create table sale_details (sale_detail_id int primary key auto_increment,sale_id int,product_id int,
    quantity int,
    selling_price decimal,
    discount decimal,
    subtotal decimal,
    foreign key (sale_id) references sales(sale_id),
    foreign key (product_id) references products(product_id)
);

create table payments (payment_id int primary key,sale_id int,payment_date date,
    amount_paid decimal,payment_mode varchar(50),
    transaction_id varchar(100),
    foreign key (sale_id) references sales(sale_id)
);

create table returns (return_id int primary key auto_increment,sale_id int,return_date date,
    total_return_amount decimal,
    reason varchar(255),
    foreign key (sale_id) references sales(sale_id)
);

create table return_details (return_detail_id int primary key auto_increment,
    return_id int,product_id int,quantity int,refund_amount decimal,
    foreign key (return_id) references returns(return_id),
    foreign key (product_id) references products(product_id)
);

create table sales_targets (target_id int primary key,employee_id int,month int,year int,
    target_amount decimal,achieved_amount decimal,
    foreign key (employee_id) references employees(employee_id)
);


	create table advertisements (ad_id int primary key auto_increment,ad_title varchar(100),
    ad_type varchar(50),start_date date,end_date date,
    budget decimal,branch_id int,
    foreign key (branch_id) references branches(branch_id)
);

create table reviews (review_id int primary key,customer_id int,product_id int,
    rating int check (rating BETWEEN 1 AND 5),review_comment varchar(255),
    review_date date,
	foreign key(customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id)
);

create table discounts (discount_id int primary key,product_id int,discount_percentage decimal,
    start_date date,end_date date,
    description varchar(255),
	foreign key (product_id) references products(product_id)
);

create table audit_logs (
    log_id int primary key auto_increment,
    table_name varchar(100),
    action_type varchar(50),
    action_date datetime default current_timestamp,
    performed_by varchar(255)
);

insert into categories (category_name, description) values
('Electronics', 'Electronic gadgets and devices'),
('Mobile Phones', 'Smartphones and accessories'),
('Laptops', 'Personal and business laptops'),
('Home Appliances', 'Appliances for home use'),
('Fashion', 'Clothing and fashion products'),
('Men Clothing', 'Clothing items for men'),
('Women Clothing', 'Clothing items for women'),
('Footwear', 'Shoes and sandals'),
('Sports', 'Sports equipment and accessories'),
('Fitness', 'Gym and fitness products'),
('Beauty', 'Beauty and skincare products'),
('Furniture', 'Home and office furniture'),
('Groceries', 'Daily grocery items'),
('Toys', 'Kids toys and games'),
('Books', 'Educational and story books'),
('Stationery', 'Office and school stationery'),
('Automobile', 'Vehicle accessories'),
('Jewellery', 'Gold and fashion jewellery'),
('Watches', 'Men and women watches'),
('Pet Supplies', 'Pet food and accessories');

select * from categories

insert into suppliers (supplier_id, supplier_name, contact_person, phone, email, city) values
(1, 'TechSource Pvt Ltd', 'Arun Kumar', '9876543210', 'arun@techsource.com', 'Chennai'),
(2, 'Global Electronics', 'Priya Sharma', '9876543211', 'priya@globalelec.com', 'Bangalore'),
(3, 'Smart Distributors', 'Ravi Verma', '9876543212', 'ravi@smartdist.com', 'Mumbai'),
(4, 'HomeNeeds Supply', 'Lakshmi Devi', '9876543213', 'lakshmi@homeneeds.com', 'Hyderabad'),
(5, 'Fashion Hub Traders', 'Meena Das', '9876543214', 'meena@fashionhub.com', 'Delhi'),
(6, 'Footwear Wholesale', 'Suresh Babu', '9876543215', 'suresh@footwear.com', 'Chennai'),
(7, 'Sports Zone Supply', 'Karthik Raj', '9876543216', 'karthik@sportszone.com', 'Coimbatore'),
(8, 'Beauty World Traders', 'Anita Singh', '9876543217', 'anita@beautyworld.com', 'Kolkata'),
(9, 'Furniture Mart', 'Rahul Jain', '9876543218', 'rahul@furnituremart.com', 'Pune'),
(10, 'Daily Fresh Grocers', 'Vikram Patel', '9876543219', 'vikram@dailyfresh.com', 'Ahmedabad'),
(11, 'ToyLand Suppliers', 'Sneha Reddy', '9876543220', 'sneha@toyland.com', 'Jaipur'),
(12, 'Book House India', 'Manoj Gupta', '9876543221', 'manoj@bookhouse.com', 'Lucknow'),
(13, 'Stationery Point', 'Divya Nair', '9876543222', 'divya@stationerypoint.com', 'Kochi'),
(14, 'AutoCare Distributors', 'Harish Kumar', '9876543223', 'harish@autocare.com', 'Chandigarh'),
(15, 'Golden Jewellery Supply', 'Pooja Mehta', '9876543224', 'pooja@goldenjewel.com', 'Surat'),
(16, 'WatchWorld Traders', 'Imran Ali', '9876543225', 'imran@watchworld.com', 'Bhopal'),
(17, 'PetCare Suppliers', 'Nandhini Rao', '9876543226', 'nandhini@petcare.com', 'Madurai'),
(18, 'Laptop Planet', 'Ajay Singh', '9876543227', 'ajay@laptopplanet.com', 'Noida'),
(19, 'Mobile Galaxy', 'Rekha Iyer', '9876543228', 'rekha@mobilegalaxy.com', 'Trichy'),
(20, 'Kitchen Essentials Co', 'Sanjay Das', '9876543229', 'sanjay@kitchenessentials.com', 'Visakhapatnam');

select * from suppliers

insert into customers 
(customer_name, gender, age, phone, email, city, state, created_date) values
('Arun Kumar', 'Male', 28, '9000011111', 'arun.kumar@gmail.com', 'Chennai', 'Tamil Nadu', '2024-01-15'),
('Priya Sharma', 'Female', 32, '9000011112', 'priya.sharma@gmail.com', 'Bangalore', 'Karnataka', '2024-02-10'),
('Ravi Verma', 'Male', 35, '9000011113', 'ravi.verma@gmail.com', 'Mumbai', 'Maharashtra', '2024-03-05'),
('Lakshmi Devi', 'Female', 27, '9000011114', 'lakshmi.devi@gmail.com', 'Hyderabad', 'Telangana', '2024-01-25'),
('Suresh Babu', 'Male', 40, '9000011115', 'suresh.babu@gmail.com', 'Coimbatore', 'Tamil Nadu', '2024-04-12'),
('Meena Das', 'Female', 30, '9000011116', 'meena.das@gmail.com', 'Delhi', 'Delhi', '2024-02-18'),
('Karthik Raj', 'Male', 26, '9000011117', 'karthik.raj@gmail.com', 'Madurai', 'Tamil Nadu', '2024-03-22'),
('Anita Singh', 'Female', 29, '9000011118', 'anita.singh@gmail.com', 'Kolkata', 'West Bengal', '2024-01-30'),
('Rahul Jain', 'Male', 33, '9000011119', 'rahul.jain@gmail.com', 'Pune', 'Maharashtra', '2024-05-01'),
('Sneha Reddy', 'Female', 24, '9000011120', 'sneha.reddy@gmail.com', 'Vijayawada', 'Andhra Pradesh', '2024-02-27'),
('Vikram Patel', 'Male', 38, '9000011121', 'vikram.patel@gmail.com', 'Ahmedabad', 'Gujarat', '2024-03-15'),
('Divya Nair', 'Female', 31, '9000011122', 'divya.nair@gmail.com', 'Kochi', 'Kerala', '2024-04-05'),
('Harish Kumar', 'Male', 45, '9000011123', 'harish.kumar@gmail.com', 'Chandigarh', 'Punjab', '2024-01-20'),
('Pooja Mehta', 'Female', 36, '9000011124', 'pooja.mehta@gmail.com', 'Surat', 'Gujarat', '2024-03-09'),
('Imran Ali', 'Male', 29, '9000011125', 'imran.ali@gmail.com', 'Bhopal', 'Madhya Pradesh', '2024-02-14'),
('Nandhini Rao', 'Female', 27, '9000011126', 'nandhini.rao@gmail.com', 'Trichy', 'Tamil Nadu', '2024-05-03'),
('Ajay Singh', 'Male', 34, '9000011127', 'ajay.singh@gmail.com', 'Noida', 'Uttar Pradesh', '2024-01-28'),
('Rekha Iyer', 'Female', 30, '9000011128', 'rekha.iyer@gmail.com', 'Chennai', 'Tamil Nadu', '2024-04-18'),
('Manoj Gupta', 'Male', 37, '9000011129', 'manoj.gupta@gmail.com', 'Lucknow', 'Uttar Pradesh', '2024-03-25'),
('Anjali Verma', 'Female', 25, '9000011130', 'anjali.verma@gmail.com', 'Jaipur', 'Rajasthan', '2024-02-08');

select * from customers

insert into branches 
(branch_name, city, state) values
('Chennai Central Branch', 'Chennai', 'Tamil Nadu'),
('Coimbatore Main Branch', 'Coimbatore', 'Tamil Nadu'),
('Madurai City Branch', 'Madurai', 'Tamil Nadu'),
('Bangalore North Branch', 'Bangalore', 'Karnataka'),
('Bangalore South Branch', 'Bangalore', 'Karnataka'),
('Hyderabad Central Branch', 'Hyderabad', 'Telangana'),
('Mumbai Andheri Branch', 'Mumbai', 'Maharashtra'),
('Mumbai Navi Branch', 'Navi Mumbai', 'Maharashtra'),
('Delhi Connaught Branch', 'Delhi', 'Delhi'),
('Pune Camp Branch', 'Pune', 'Maharashtra'),
('Kolkata Park Street Branch', 'Kolkata', 'West Bengal'),
('Ahmedabad City Branch', 'Ahmedabad', 'Gujarat'),
('Surat Textile Branch', 'Surat', 'Gujarat'),
('Jaipur Pink City Branch', 'Jaipur', 'Rajasthan'),
('Lucknow Hazratganj Branch', 'Lucknow', 'Uttar Pradesh'),
('Bhopal MP Nagar Branch', 'Bhopal', 'Madhya Pradesh'),
('Kochi Marine Drive Branch', 'Kochi', 'Kerala'),
('Chandigarh Sector 17 Branch', 'Chandigarh', 'Punjab'),
('Vijayawada Benz Circle Branch', 'Vijayawada', 'Andhra Pradesh'),
('Noida Sector 18 Branch', 'Noida', 'Uttar Pradesh');

select * from branches

insert into managers 
(manager_name, salary, phone, email, branch_id) values
('Rajesh Kumar', 75000.00, '9100000001', 'rajesh.kumar@company.com', 1),
('Priya Menon', 72000.00, '9100000002', 'priya.menon@company.com', 2),
('Suresh Reddy', 68000.00, '9100000003', 'suresh.reddy@company.com', 3),
('Anita Sharma', 80000.00, '9100000004', 'anita.sharma@company.com', 4),
('Vikram Singh', 85000.00, '9100000005', 'vikram.singh@company.com', 5),
('Lakshmi Narayanan', 70000.00, '9100000006', 'lakshmi.n@company.com', 6),
('Karthik Subramanian', 73000.00, '9100000007', 'karthik.s@company.com', 7),
('Meena Gupta', 69000.00, '9100000008', 'meena.gupta@company.com', 8),
('Rahul Jain', 76000.00, '9100000009', 'rahul.jain@company.com', 9),
('Divya Nair', 71000.00, '9100000010', 'divya.nair@company.com', 10),
('Arun Prakash', 82000.00, '9100000011', 'arun.prakash@company.com', 11),
('Sneha Patel', 74000.00, '9100000012', 'sneha.patel@company.com', 12),
('Manoj Verma', 67000.00, '9100000013', 'manoj.verma@company.com', 13),
('Pooja Iyer', 79000.00, '9100000014', 'pooja.iyer@company.com', 14),
('Imran Khan', 83000.00, '9100000015', 'imran.khan@company.com', 15),
('Nandhini Rao', 72000.00, '9100000016', 'nandhini.rao@company.com', 16),
('Ajay Das', 76000.00, '9100000017', 'ajay.das@company.com', 17),
('Rekha Sharma', 81000.00, '9100000018', 'rekha.sharma@company.com', 18),
('Harish Babu', 70000.00, '9100000019', 'harish.babu@company.com', 19),
('Anjali Kapoor', 78000.00, '9100000020', 'anjali.kapoor@company.com', 20);

select * from managers

insert into employees 
(employee_name, role, salary, phone, email, branch_id, manager_id, hire_date) values
('Arun Prasad', 'Sales Executive', 35000.00, '9200000001', 'arun.prasad@company.com', 1, 1, '2023-01-10'),
('Priyanka Rao', 'Cashier', 28000.00, '9200000002', 'priyanka.rao@company.com', 2, 2, '2023-02-15'),
('Ramesh Kumar', 'Sales Executive', 36000.00, '9200000003', 'ramesh.kumar@company.com', 3, 3, '2023-03-12'),
('Divya Sharma', 'Inventory Staff', 30000.00, '9200000004', 'divya.sharma@company.com', 4, 4, '2023-04-01'),
('Karthik Raj', 'Sales Executive', 34000.00, '9200000005', 'karthik.raj@company.com', 5, 5, '2023-05-20'),
('Sneha Iyer', 'HR Executive', 40000.00, '9200000006', 'sneha.iyer@company.com', 6, 6, '2023-06-18'),
('Vignesh Babu', 'Sales Executive', 35500.00, '9200000007', 'vignesh.babu@company.com', 7, 7, '2023-07-11'),
('Anjali Mehta', 'Cashier', 29000.00, '9200000008', 'anjali.mehta@company.com', 8, 8, '2023-08-09'),
('Rahul Verma', 'Sales Executive', 37000.00, '9200000009', 'rahul.verma@company.com', 9, 9, '2023-09-14'),
('Meena Nair', 'Inventory Staff', 31000.00, '9200000010', 'meena.nair@company.com', 10, 10, '2023-10-01'),
('Sanjay Patel', 'Sales Executive', 36000.00, '9200000011', 'sanjay.patel@company.com', 11, 11, '2023-01-25'),
('Lakshmi Devi', 'Cashier', 28500.00, '9200000012', 'lakshmi.devi@company.com', 12, 12, '2023-02-28'),
('Imran Khan', 'Sales Executive', 37500.00, '9200000013', 'imran.khan@company.com', 13, 13, '2023-03-30'),
('Pooja Sharma', 'Inventory Staff', 30500.00, '9200000014', 'pooja.sharma@company.com', 14, 14, '2023-04-22'),
('Ajay Singh', 'Sales Executive', 36500.00, '9200000015', 'ajay.singh@company.com', 15, 15, '2023-05-16'),
('Nandhini Rao', 'HR Executive', 42000.00, '9200000016', 'nandhini.rao@company.com', 16, 16, '2023-06-12'),
('Harish Kumar', 'Sales Executive', 35000.00, '9200000017', 'harish.kumar@company.com', 17, 17, '2023-07-19'),
('Rekha Menon', 'Cashier', 29500.00, '9200000018', 'rekha.menon@company.com', 18, 18, '2023-08-23'),
('Manoj Gupta', 'Sales Executive', 38000.00, '9200000019', 'manoj.gupta@company.com', 19, 19, '2023-09-05'),
('Anita Reddy', 'Inventory Staff', 31500.00, '9200000020', 'anita.reddy@company.com', 20, 20, '2023-10-10');

select * from employees

insert into products 
(product_name, category_id, brand, cost_price, selling_price, barcode, created_date) values
('iPhone 14', 2, 'Apple', 60000.00, 75000.00, 'ELEC1001', '2024-01-10'),
('Samsung Galaxy S23', 2, 'Samsung', 50000.00, 65000.00, 'ELEC1002', '2024-01-12'),
('Dell Inspiron 15', 3, 'Dell', 45000.00, 55000.00, 'LAP1003', '2024-02-01'),
('HP Pavilion', 3, 'HP', 42000.00, 52000.00, 'LAP1004', '2024-02-05'),
('LG Refrigerator', 4, 'LG', 30000.00, 38000.00, 'HOME1005', '2024-02-15'),
('Sony LED TV', 4, 'Sony', 40000.00, 48000.00, 'HOME1006', '2024-02-18'),
('Men T-Shirt', 6, 'Levis', 500.00, 899.00, 'FASH1007', '2024-03-01'),
('Women Saree', 7, 'Pothys', 1200.00, 1999.00, 'FASH1008', '2024-03-03'),
('Running Shoes', 8, 'Nike', 2500.00, 3999.00, 'SPRT1009', '2024-03-10'),
('Cricket Bat', 9, 'SG', 1500.00, 2499.00, 'SPRT1010', '2024-03-12'),
('Dumbbell Set', 10, 'ProFit', 2000.00, 3200.00, 'FIT1011', '2024-03-20'),
('Face Cream', 11, 'Lakme', 150.00, 299.00, 'BEAU1012', '2024-04-01'),
('Office Chair', 12, 'Godrej', 3500.00, 4999.00, 'FURN1013', '2024-04-05'),
('Rice 25kg Bag', 13, 'IndiaGate', 1200.00, 1500.00, 'GROC1014', '2024-04-08'),
('Kids Toy Car', 14, 'Funskool', 600.00, 999.00, 'TOY1015', '2024-04-12'),
('Python Programming Book', 15, 'OReilly', 700.00, 999.00, 'BOOK1016', '2024-04-18'),
('Notebook Pack', 16, 'Classmate', 80.00, 120.00, 'STAT1017', '2024-04-20'),
('Car Seat Cover', 17, 'AutoCare', 1500.00, 2200.00, 'AUTO1018', '2024-05-01'),
('Gold Necklace', 18, 'Tanishq', 45000.00, 52000.00, 'JEW1019', '2024-05-05'),
('Men Wrist Watch', 19, 'Titan', 3000.00, 4500.00, 'WATCH1020', '2024-05-10');

select * from products

insert into inventory
(product_id, stock_quantity, reorder_level, last_updated) values
(1, 50, 10, '2024-05-15'),
(2, 40, 8, '2024-05-15'),
(3, 30, 5, '2024-05-16'),
(4, 25, 5, '2024-05-16'),
(5, 20, 4, '2024-05-17'),
(6, 18, 3, '2024-05-17'),
(7, 100, 20, '2024-05-18'),
(8, 80, 15, '2024-05-18'),
(9, 60, 10, '2024-05-19'),
(10, 45, 8, '2024-05-19'),
(11, 35, 6, '2024-05-20'),
(12, 120, 25, '2024-05-20'),
(13, 22, 5, '2024-05-21'),
(14, 75, 12, '2024-05-21'),
(15, 90, 15, '2024-05-22'),
(16, 55, 10, '2024-05-22'),
(17, 200, 50, '2024-05-23'),
(18, 28, 6, '2024-05-23'),
(19, 10, 2, '2024-05-24'),
(20, 65, 10, '2024-05-24');

select * from inventory

insert into purchases
(supplier_id, purchase_date, total_amount, status) values
(1, '2024-01-05', 150000.00, 'Completed'),
(2, '2024-01-12', 120000.00, 'Completed'),
(3, '2024-01-20', 95000.00, 'Completed'),
(4, '2024-02-02', 80000.00, 'Completed'),
(5, '2024-02-10', 60000.00, 'Pending'),
(6, '2024-02-18', 45000.00, 'Completed'),
(7, '2024-03-01', 70000.00, 'Completed'),
(8, '2024-03-08', 50000.00, 'Pending'),
(9, '2024-03-15', 88000.00, 'Completed'),
(10, '2024-03-22', 40000.00, 'Completed'),
(11, '2024-04-05', 76000.00, 'Completed'),
(12, '2024-04-12', 54000.00, 'Completed'),
(13, '2024-04-18', 32000.00, 'Pending'),
(14, '2024-04-25', 67000.00, 'Completed'),
(15, '2024-05-02', 110000.00, 'Completed'),
(16, '2024-05-08', 47000.00, 'Completed'),
(17, '2024-05-15', 39000.00, 'Pending'),
(18, '2024-05-20', 85000.00, 'Completed'),
(19, '2024-05-25', 92000.00, 'Completed'),
(20, '2024-05-30', 58000.00, 'Completed');

select * from purchases

insert into purchase_details
(purchase_id, product_id, quantity, purchase_price, subtotal) values
(1, 1, 50, 1000.00, 50000.00),
(1, 2, 30, 1500.00, 45000.00),
(2, 3, 40, 800.00, 32000.00),
(2, 4, 20, 2000.00, 40000.00),
(3, 5, 25, 1200.00, 30000.00),
(3, 6, 15, 1500.00, 22500.00),
(4, 7, 60, 500.00, 30000.00),
(4, 8, 40, 750.00, 30000.00),
(5, 9, 35, 900.00, 31500.00),
(5, 10, 10, 1200.00, 12000.00),
(6, 11, 45, 600.00, 27000.00),
(6, 12, 20, 1100.00, 22000.00),
(7, 13, 18, 1400.00, 25200.00),
(8, 14, 50, 800.00, 40000.00),
(9, 15, 70, 700.00, 49000.00),
(10, 16, 22, 1600.00, 35200.00),
(11, 17, 100, 300.00, 30000.00),
(12, 18, 28, 950.00, 26600.00),
(13, 19, 12, 2000.00, 24000.00),
(14, 20, 30, 850.00, 25500.00);

select * from purchase_details 

insert into sales (customer_id, sale_date, total_amount, discount, final_amount, payment_status) values
(1,'2024-01-01',5000,200,4800,'Paid'),
(2,'2024-01-02',4500,200,4300,'Paid'),
(3,'2024-01-03',6000,300,5700,'Pending'),
(4,'2024-01-04',3200,100,3100,'Paid'),
(5,'2024-01-05',2800,100,2700,'Paid'),
(6,'2024-01-06',7200,400,6800,'Pending'),
(7,'2024-01-07',5100,200,4900,'Paid'),
(8,'2024-01-08',4600,200,4400,'Paid'),
(9,'2024-01-09',3900,150,3750,'Paid'),
(10,'2024-01-10',8400,600,7800,'Pending'),
(11,'2024-01-11',2500,100,2400,'Paid'),
(12,'2024-01-12',6700,300,6400,'Paid'),
(13,'2024-01-13',7200,400,6800,'Pending'),
(14,'2024-01-14',5800,300,5500,'Paid'),
(15,'2024-01-15',3100,100,3000,'Paid'),
(16,'2024-01-16',4700,200,4500,'Paid'),
(17,'2024-01-17',5400,300,5100,'Pending'),
(18,'2024-01-18',6100,300,5800,'Paid'),
(19,'2024-01-19',7000,400,6600,'Paid'),
(20,'2024-01-20',2600,100,2500,'Paid'),

(1,'2024-01-21',3500,200,3300,'Pending'),
(2,'2024-01-22',4300,200,4100,'Paid'),
(3,'2024-01-23',3900,100,3800,'Paid'),
(4,'2024-01-24',6200,300,5900,'Paid'),
(5,'2024-01-25',7400,400,7000,'Pending'),
(6,'2024-01-26',5200,200,5000,'Paid'),
(7,'2024-01-27',4800,200,4600,'Paid'),
(8,'2024-01-28',8300,500,7800,'Paid'),
(9,'2024-01-29',9100,700,8400,'Pending'),
(10,'2024-01-30',2700,100,2600,'Paid'),

(11,'2024-02-01',3800,200,3600,'Paid'),
(12,'2024-02-02',4400,200,4200,'Pending'),
(13,'2024-02-03',5200,200,5000,'Paid'),
(14,'2024-02-04',6100,300,5800,'Paid'),
(15,'2024-02-05',7300,400,6900,'Pending'),
(16,'2024-02-06',4900,200,4700,'Paid'),
(17,'2024-02-07',5600,200,5400,'Paid'),
(18,'2024-02-08',6400,300,6100,'Paid'),
(19,'2024-02-09',8200,600,7600,'Pending'),
(20,'2024-02-10',2600,100,2500,'Paid'),

(1,'2024-02-11',3300,150,3150,'Paid'),
(2,'2024-02-12',4100,200,3900,'Paid'),
(3,'2024-02-13',5200,300,4900,'Pending'),
(4,'2024-02-14',6800,400,6400,'Paid'),
(5,'2024-02-15',7500,500,7000,'Paid'),
(6,'2024-02-16',4700,200,4500,'Paid'),
(7,'2024-02-17',5400,200,5200,'Pending'),
(8,'2024-02-18',6200,300,5900,'Paid'),
(9,'2024-02-19',8000,600,7400,'Paid'),
(10,'2024-02-20',2900,100,2800,'Paid'),

(11,'2024-02-21',3600,200,3400,'Pending'),
(12,'2024-02-22',4300,200,4100,'Paid'),
(13,'2024-02-23',5100,200,4900,'Paid'),
(14,'2024-02-24',6900,400,6500,'Paid'),
(15,'2024-02-25',7200,400,6800,'Pending'),
(16,'2024-02-26',4800,200,4600,'Paid'),
(17,'2024-02-27',5500,200,5300,'Paid'),
(18,'2024-02-28',6100,300,5800,'Paid'),
(19,'2024-02-29',8300,600,7700,'Pending'),
(20,'2024-03-01',3000,100,2900,'Paid'),

(1,'2024-03-02',3400,200,3200,'Paid'),
(2,'2024-03-03',4500,200,4300,'Pending'),
(3,'2024-03-04',5200,200,5000,'Paid'),
(4,'2024-03-05',6100,300,5800,'Paid'),
(5,'2024-03-06',7300,400,6900,'Paid'),
(6,'2024-03-07',4900,200,4700,'Pending'),
(7,'2024-03-08',5600,200,5400,'Paid'),
(8,'2024-03-09',6400,300,6100,'Paid'),
(9,'2024-03-10',8200,600,7600,'Paid'),
(10,'2024-03-11',3100,100,3000,'Pending'),

(11,'2024-03-12',3700,200,3500,'Paid'),
(12,'2024-03-13',4400,200,4200,'Paid'),
(13,'2024-03-14',5200,200,5000,'Paid'),
(14,'2024-03-15',7000,400,6600,'Pending'),
(15,'2024-03-16',7400,400,7000,'Paid'),
(16,'2024-03-17',5000,200,4800,'Paid'),
(17,'2024-03-18',5600,200,5400,'Paid'),
(18,'2024-03-19',6200,300,5900,'Pending'),
(19,'2024-03-20',8500,600,7900,'Paid'),
(20,'2024-03-21',3200,100,3100,'Paid');

select * from sales
DELETE FROM sales;
TRUNCATE TABLE sales;

ALTER TABLE sales AUTO_INCREMENT = 1;

insert into sales (sale_id, customer_id, sale_date, total_amount, discount, final_amount,
 payment_status) values
(1,1,'2024-01-01',1000,50,950,'Paid'),
(2,2,'2024-01-02',1200,100,1100,'Paid'),
(3,3,'2024-01-03',900,50,850,'Pending'),
(4,4,'2024-01-04',1500,200,1300,'Paid'),
(5,5,'2024-01-05',2000,200,1800,'Paid'),
(6,6,'2024-01-06',1100,100,1000,'Pending'),
(7,7,'2024-01-07',1300,100,1200,'Paid'),
(8,8,'2024-01-08',1700,200,1500,'Paid'),
(9,9,'2024-01-09',900,50,850,'Pending'),
(10,10,'2024-01-10',2200,200,2000,'Paid'),

(11,1,'2024-01-11',1400,100,1300,'Paid'),
(12,2,'2024-01-12',1600,200,1400,'Pending'),
(13,3,'2024-01-13',1000,50,950,'Paid'),
(14,4,'2024-01-14',2100,200,1900,'Paid'),
(15,5,'2024-01-15',1800,200,1600,'Pending'),
(16,6,'2024-01-16',1200,100,1100,'Paid'),
(17,7,'2024-01-17',1500,100,1400,'Paid'),
(18,8,'2024-01-18',1900,200,1700,'Pending'),
(19,9,'2024-01-19',800,50,750,'Paid'),
(20,10,'2024-01-20',2300,300,2000,'Paid'),

(21,1,'2024-01-21',1400,100,1300,'Pending'),
(22,2,'2024-01-22',1600,200,1400,'Paid'),
(23,3,'2024-01-23',1000,50,950,'Paid'),
(24,4,'2024-01-24',2100,200,1900,'Pending'),
(25,5,'2024-01-25',1800,200,1600,'Paid'),
(26,6,'2024-01-26',1200,100,1100,'Paid'),
(27,7,'2024-01-27',1500,100,1400,'Pending'),
(28,8,'2024-01-28',1900,200,1700,'Paid'),
(29,9,'2024-01-29',800,50,750,'Paid'),
(30,10,'2024-01-30',2300,300,2000,'Pending'),

(31,1,'2024-02-01',1400,100,1300,'Paid'),
(32,2,'2024-02-02',1600,200,1400,'Pending'),
(33,3,'2024-02-03',1000,50,950,'Paid'),
(34,4,'2024-02-04',2100,200,1900,'Paid'),
(35,5,'2024-02-05',1800,200,1600,'Pending'),
(36,6,'2024-02-06',1200,100,1100,'Paid'),
(37,7,'2024-02-07',1500,100,1400,'Paid'),
(38,8,'2024-02-08',1900,200,1700,'Pending'),
(39,9,'2024-02-09',800,50,750,'Paid'),
(40,10,'2024-02-10',2300,300,2000,'Paid'),

(41,1,'2024-02-11',1400,100,1300,'Pending'),
(42,2,'2024-02-12',1600,200,1400,'Paid'),
(43,3,'2024-02-13',1000,50,950,'Paid'),
(44,4,'2024-02-14',2100,200,1900,'Pending'),
(45,5,'2024-02-15',1800,200,1600,'Paid'),
(46,6,'2024-02-16',1200,100,1100,'Paid'),
(47,7,'2024-02-17',1500,100,1400,'Pending'),
(48,8,'2024-02-18',1900,200,1700,'Paid'),
(49,9,'2024-02-19',800,50,750,'Paid'),
(50,10,'2024-02-20',2300,300,2000,'Pending'),

(51,1,'2024-02-21',1400,100,1300,'Paid'),
(52,2,'2024-02-22',1600,200,1400,'Pending'),
(53,3,'2024-02-23',1000,50,950,'Paid'),
(54,4,'2024-02-24',2100,200,1900,'Paid'),
(55,5,'2024-02-25',1800,200,1600,'Pending'),
(56,6,'2024-02-26',1200,100,1100,'Paid'),
(57,7,'2024-02-27',1500,100,1400,'Paid'),
(58,8,'2024-02-28',1900,200,1700,'Pending'),
(59,9,'2024-02-29',800,50,750,'Paid'),
(60,10,'2024-03-01',2300,300,2000,'Paid'),

(61,1,'2024-03-02',1400,100,1300,'Pending'),
(62,2,'2024-03-03',1600,200,1400,'Paid'),
(63,3,'2024-03-04',1000,50,950,'Paid'),
(64,4,'2024-03-05',2100,200,1900,'Pending'),
(65,5,'2024-03-06',1800,200,1600,'Paid'),
(66,6,'2024-03-07',1200,100,1100,'Paid'),
(67,7,'2024-03-08',1500,100,1400,'Pending'),
(68,8,'2024-03-09',1900,200,1700,'Paid'),
(69,9,'2024-03-10',800,50,750,'Paid'),
(70,10,'2024-03-11',2300,300,2000,'Pending'),

(71,1,'2024-03-12',1400,100,1300,'Paid'),
(72,2,'2024-03-13',1600,200,1400,'Pending'),
(73,3,'2024-03-14',1000,50,950,'Paid'),
(74,4,'2024-03-15',2100,200,1900,'Paid'),
(75,5,'2024-03-16',1800,200,1600,'Pending'),
(76,6,'2024-03-17',1200,100,1100,'Paid'),
(77,7,'2024-03-18',1500,100,1400,'Paid'),
(78,8,'2024-03-19',1900,200,1700,'Pending'),
(79,9,'2024-03-20',800,50,750,'Paid'),
(80,10,'2024-03-21',2300,300,2000,'Paid'),

(81,1,'2024-03-22',1400,100,1300,'Pending'),
(82,2,'2024-03-23',1600,200,1400,'Paid'),
(83,3,'2024-03-24',1000,50,950,'Paid'),
(84,4,'2024-03-25',2100,200,1900,'Pending'),
(85,5,'2024-03-26',1800,200,1600,'Paid'),
(86,6,'2024-03-27',1200,100,1100,'Paid'),
(87,7,'2024-03-28',1500,100,1400,'Pending'),
(88,8,'2024-03-29',1900,200,1700,'Paid'),
(89,9,'2024-03-30',800,50,750,'Paid'),
(90,10,'2024-03-31',2300,300,2000,'Pending'),

(91,1,'2024-04-01',1400,100,1300,'Paid'),
(92,2,'2024-04-02',1600,200,1400,'Pending'),
(93,3,'2024-04-03',1000,50,950,'Paid'),
(94,4,'2024-04-04',2100,200,1900,'Paid'),
(95,5,'2024-04-05',1800,200,1600,'Pending'),
(96,6,'2024-04-06',1200,100,1100,'Paid'),
(97,7,'2024-04-07',1500,100,1400,'Paid'),
(98,8,'2024-04-08',1900,200,1700,'Pending'),
(99,9,'2024-04-09',800,50,750,'Paid'),
(100,10,'2024-04-10',2300,300,2000,'Paid');

DELETE FROM sales;

ALTER TABLE sales AUTO_INCREMENT = 1;
SELECT * FROM sales;

insert into sales (sale_id, customer_id, sale_date, total_amount, discount, final_amount, 
payment_status) values
(1,1,'2024-01-01',1000,50,950,'Paid'),
(2,2,'2024-01-02',1200,100,1100,'Paid'),
(3,3,'2024-01-03',900,50,850,'Pending'),
(4,4,'2024-01-04',1500,200,1300,'Paid'),
(5,5,'2024-01-05',2000,200,1800,'Paid'),
(6,6,'2024-01-06',1100,100,1000,'Pending'),
(7,7,'2024-01-07',1300,100,1200,'Paid'),
(8,8,'2024-01-08',1700,200,1500,'Paid'),
(9,9,'2024-01-09',900,50,850,'Pending'),
(10,10,'2024-01-10',2200,200,2000,'Paid'),

(11,1,'2024-01-11',1400,100,1300,'Paid'),
(12,2,'2024-01-12',1600,200,1400,'Pending'),
(13,3,'2024-01-13',1000,50,950,'Paid'),
(14,4,'2024-01-14',2100,200,1900,'Paid'),
(15,5,'2024-01-15',1800,200,1600,'Pending'),
(16,6,'2024-01-16',1200,100,1100,'Paid'),
(17,7,'2024-01-17',1500,100,1400,'Paid'),
(18,8,'2024-01-18',1900,200,1700,'Pending'),
(19,9,'2024-01-19',800,50,750,'Paid'),
(20,10,'2024-01-20',2300,300,2000,'Paid'),

(21,1,'2024-01-21',1400,100,1300,'Pending'),
(22,2,'2024-01-22',1600,200,1400,'Paid'),
(23,3,'2024-01-23',1000,50,950,'Paid'),
(24,4,'2024-01-24',2100,200,1900,'Pending'),
(25,5,'2024-01-25',1800,200,1600,'Paid'),
(26,6,'2024-01-26',1200,100,1100,'Paid'),
(27,7,'2024-01-27',1500,100,1400,'Pending'),
(28,8,'2024-01-28',1900,200,1700,'Paid'),
(29,9,'2024-01-29',800,50,750,'Paid'),
(30,10,'2024-01-30',2300,300,2000,'Pending'),

(31,1,'2024-02-01',1400,100,1300,'Paid'),
(32,2,'2024-02-02',1600,200,1400,'Pending'),
(33,3,'2024-02-03',1000,50,950,'Paid'),
(34,4,'2024-02-04',2100,200,1900,'Paid'),
(35,5,'2024-02-05',1800,200,1600,'Pending'),
(36,6,'2024-02-06',1200,100,1100,'Paid'),
(37,7,'2024-02-07',1500,100,1400,'Paid'),
(38,8,'2024-02-08',1900,200,1700,'Pending'),
(39,9,'2024-02-09',800,50,750,'Paid'),
(40,10,'2024-02-10',2300,300,2000,'Paid'),

(41,1,'2024-02-11',1400,100,1300,'Pending'),
(42,2,'2024-02-12',1600,200,1400,'Paid'),
(43,3,'2024-02-13',1000,50,950,'Paid'),
(44,4,'2024-02-14',2100,200,1900,'Pending'),
(45,5,'2024-02-15',1800,200,1600,'Paid'),
(46,6,'2024-02-16',1200,100,1100,'Paid'),
(47,7,'2024-02-17',1500,100,1400,'Pending'),
(48,8,'2024-02-18',1900,200,1700,'Paid'),
(49,9,'2024-02-19',800,50,750,'Paid'),
(50,10,'2024-02-20',2300,300,2000,'Pending'),

(51,1,'2024-02-21',1400,100,1300,'Paid'),
(52,2,'2024-02-22',1600,200,1400,'Pending'),
(53,3,'2024-02-23',1000,50,950,'Paid'),
(54,4,'2024-02-24',2100,200,1900,'Paid'),
(55,5,'2024-02-25',1800,200,1600,'Pending'),
(56,6,'2024-02-26',1200,100,1100,'Paid'),
(57,7,'2024-02-27',1500,100,1400,'Paid'),
(58,8,'2024-02-28',1900,200,1700,'Pending'),
(59,9,'2024-02-29',800,50,750,'Paid'),
(60,10,'2024-03-01',2300,300,2000,'Paid'),

(61,1,'2024-03-02',1400,100,1300,'Pending'),
(62,2,'2024-03-03',1600,200,1400,'Paid'),
(63,3,'2024-03-04',1000,50,950,'Paid'),
(64,4,'2024-03-05',2100,200,1900,'Pending'),
(65,5,'2024-03-06',1800,200,1600,'Paid'),
(66,6,'2024-03-07',1200,100,1100,'Paid'),
(67,7,'2024-03-08',1500,100,1400,'Pending'),
(68,8,'2024-03-09',1900,200,1700,'Paid'),
(69,9,'2024-03-10',800,50,750,'Paid'),
(70,10,'2024-03-11',2300,300,2000,'Pending'),

(71,1,'2024-03-12',1400,100,1300,'Paid'),
(72,2,'2024-03-13',1600,200,1400,'Pending'),
(73,3,'2024-03-14',1000,50,950,'Paid'),
(74,4,'2024-03-15',2100,200,1900,'Paid'),
(75,5,'2024-03-16',1800,200,1600,'Pending'),
(76,6,'2024-03-17',1200,100,1100,'Paid'),
(77,7,'2024-03-18',1500,100,1400,'Paid'),
(78,8,'2024-03-19',1900,200,1700,'Pending'),
(79,9,'2024-03-20',800,50,750,'Paid'),
(80,10,'2024-03-21',2300,300,2000,'Paid'),

(81,1,'2024-03-22',1400,100,1300,'Pending'),
(82,2,'2024-03-23',1600,200,1400,'Paid'),
(83,3,'2024-03-24',1000,50,950,'Paid'),
(84,4,'2024-03-25',2100,200,1900,'Pending'),
(85,5,'2024-03-26',1800,200,1600,'Paid'),
(86,6,'2024-03-27',1200,100,1100,'Paid'),
(87,7,'2024-03-28',1500,100,1400,'Pending'),
(88,8,'2024-03-29',1900,200,1700,'Paid'),
(89,9,'2024-03-30',800,50,750,'Paid'),
(90,10,'2024-03-31',2300,300,2000,'Pending'),

(91,1,'2024-04-01',1400,100,1300,'Paid'),
(92,2,'2024-04-02',1600,200,1400,'Pending'),
(93,3,'2024-04-03',1000,50,950,'Paid'),
(94,4,'2024-04-04',2100,200,1900,'Paid'),
(95,5,'2024-04-05',1800,200,1600,'Pending'),
(96,6,'2024-04-06',1200,100,1100,'Paid'),
(97,7,'2024-04-07',1500,100,1400,'Paid'),
(98,8,'2024-04-08',1900,200,1700,'Pending'),
(99,9,'2024-04-09',800,50,750,'Paid'),
(100,10,'2024-04-10',2300,300,2000,'Paid');

insert into sale_details (sale_id, product_id, quantity, selling_price, discount, subtotal) values
(1,1,2,1200,100,2300),
(2,3,1,800,50,750),
(3,5,3,500,100,1400),
(4,2,2,1500,200,2800),
(5,4,1,900,50,850),
(6,6,2,700,50,1350),
(7,7,1,2000,200,1800),
(8,8,4,300,50,1150),
(9,9,2,600,50,1150),
(10,10,3,400,100,1100),
(11,11,2,750,50,1450),
(12,12,1,1300,100,1200),
(13,13,5,250,50,1200),
(14,14,2,900,100,1700),
(15,15,3,450,50,1300),
(16,16,1,2200,200,2000),
(17,17,2,650,50,1250),
(18,18,4,350,100,1300),
(19,19,2,800,100,1500),
(20,20,3,500,50,1450);

select * from sale_details

ALTER TABLE payments
MODIFY payment_date DATE;

insert into payments 
(payment_id, sale_id, payment_date, amount_paid, payment_mode, transaction_id) values
(1,1,'2024-01-01',950,'UPI','TXN1001'),
(2,2,'2024-01-02',1100,'Card','TXN1002'),
(3,3,'2024-01-03',850,'Cash','TXN1003'),
(4,4,'2024-01-04',1400,'UPI','TXN1004'),
(5,5,'2024-01-05',900,'Card','TXN1005'),
(6,6,'2024-01-06',1250,'Cash','TXN1006'),
(7,7,'2024-01-07',1500,'UPI','TXN1007'),
(8,8,'2024-01-08',1350,'Card','TXN1008'),
(9,9,'2024-01-09',1700,'UPI','TXN1009'),
(10,10,'2024-01-10',2100,'Cash','TXN1010'),
(11,11,'2024-01-11',1800,'Card','TXN1011'),
(12,12,'2024-01-12',950,'UPI','TXN1012'),
(13,13,'2024-01-13',1200,'Cash','TXN1013'),
(14,14,'2024-01-14',1400,'Card','TXN1014'),
(15,15,'2024-01-15',1600,'UPI','TXN1015'),
(16,16,'2024-01-16',1750,'Cash','TXN1016'),
(17,17,'2024-01-17',2000,'Card','TXN1017'),
(18,18,'2024-01-18',2200,'UPI','TXN1018'),
(19,19,'2024-01-19',1450,'Cash','TXN1019'),
(20,20,'2024-01-20',1300,'Card','TXN1020');

select * from payments

alter table returns auto_increment=101;

insert into returns (sale_id, return_date, total_return_amount, reason) values
(5,'2024-02-01',500,'Damaged product'),
(8,'2024-02-03',700,'Wrong item delivered'),
(12,'2024-02-05',400,'Customer not satisfied'),
(15,'2024-02-07',900,'Product defect'),
(18,'2024-02-09',650,'Size issue'),
(20,'2024-02-10',300,'Late delivery'),
(25,'2024-02-12',750,'Damaged packaging'),
(28,'2024-02-14',550,'Wrong color'),
(30,'2024-02-16',600,'Product defect'),
(34,'2024-02-18',450,'Customer cancelled'),
(38,'2024-02-20',800,'Quality issue'),
(40,'2024-02-22',350,'Wrong product'),
(45,'2024-02-24',500,'Damaged item'),
(50,'2024-02-26',700,'Customer not satisfied'),
(55,'2024-02-28',650,'Product defect'),
(60,'2024-03-01',400,'Late delivery'),
(65,'2024-03-03',550,'Size issue'),
(70,'2024-03-05',720,'Wrong item'),
(75,'2024-03-07',480,'Damaged packaging'),
(80,'2024-03-09',900,'Quality issue');

select * from returns

ALTER TABLE return_details AUTO_INCREMENT = 5;

insert into return_details (return_id, product_id, quantity, refund_amount) values
(101,1,1,500),
(102,2,2,700),
(103,3,1,400),
(104,4,1,900),
(105,5,2,650),
(106,6,1,300),
(107,7,3,750),
(108,8,2,550),
(109,9,1,600),
(110,10,1,450),
(111,11,2,800),
(112,12,1,350),
(113,13,2,500),
(114,14,1,700),
(115,15,2,650),
(116,16,1,400),
(117,17,1,550),
(118,18,2,720),
(119,19,1,480),
(120,20,2,900);

select * from return_details

insert into sales_targets 
(target_id, employee_id, month, year, target_amount, achieved_amount) values
(1,1,1,2024,50000,48000),
(2,2,1,2024,60000,55000),
(3,3,1,2024,45000,42000),
(4,4,1,2024,70000,68000),
(5,5,1,2024,55000,50000),
(6,6,2,2024,65000,62000),
(7,7,2,2024,48000,46000),
(8,8,2,2024,72000,70000),
(9,9,2,2024,53000,50000),
(10,10,2,2024,60000,58000),
(11,11,3,2024,75000,72000),
(12,12,3,2024,62000,60000),
(13,13,3,2024,50000,47000),
(14,14,3,2024,68000,65000),
(15,15,4,2024,72000,69000),
(16,16,4,2024,58000,55000),
(17,17,4,2024,64000,62000),
(18,18,4,2024,70000,68000),
(19,19,5,2024,56000,53000),
(20,20,5,2024,61000,59000);

select * from sales_targets

insert into advertisements 
(ad_title, ad_type, start_date, end_date, budget, branch_id) values
('New Year Sale','Online','2024-01-01','2024-01-10',20000,1),
('Festival Offer','TV','2024-01-15','2024-01-25',35000,2),
('Summer Sale','Banner','2024-02-01','2024-02-15',15000,3),
('Mega Discount','Social Media','2024-02-10','2024-02-20',18000,4),
('Valentine Offer','Online','2024-02-05','2024-02-14',22000,5),
('Republic Day Sale','TV','2024-01-20','2024-01-26',30000,6),
('Winter Clearance','Banner','2024-01-05','2024-01-18',12000,7),
('Flash Sale','Social Media','2024-02-12','2024-02-18',16000,8),
('Weekend Offer','Online','2024-03-01','2024-03-05',14000,9),
('Special Discount','TV','2024-03-05','2024-03-12',28000,10),
('Holiday Sale','Banner','2024-03-10','2024-03-20',17000,1),
('Grand Opening','Social Media','2024-03-15','2024-03-25',25000,2),
('Customer Festival','Online','2024-04-01','2024-04-10',21000,3),
('Mega Weekend','TV','2024-04-05','2024-04-15',32000,4),
('Special Combo Offer','Banner','2024-04-10','2024-04-18',13000,5),
('Spring Sale','Social Media','2024-04-15','2024-04-25',19000,6),
('Discount Bonanza','Online','2024-05-01','2024-05-10',23000,7),
('Big Savings','TV','2024-05-05','2024-05-15',34000,8),
('Limited Offer','Banner','2024-05-10','2024-05-18',16000,9),
('Customer Special','Social Media','2024-05-15','2024-05-25',20000,10);

select * from advertisements 

insert into reviews 
(review_id, customer_id, product_id, rating, review_comment, review_date) values
(1,1,2,5,'Excellent product','2024-01-05'),
(2,2,4,4,'Very good quality','2024-01-07'),
(3,3,6,3,'Average performance','2024-01-10'),
(4,4,1,5,'Highly recommended','2024-01-12'),
(5,5,3,2,'Not satisfied','2024-01-15'),
(6,6,5,4,'Good value for money','2024-01-18'),
(7,7,7,5,'Amazing product','2024-01-20'),
(8,8,9,3,'Okay product','2024-01-22'),
(9,9,8,4,'Nice quality','2024-01-25'),
(10,10,10,1,'Very poor quality','2024-01-28'),
(11,11,12,5,'Perfect item','2024-02-01'),
(12,12,14,4,'Works well','2024-02-03'),
(13,13,11,3,'Average experience','2024-02-06'),
(14,14,13,2,'Not as expected','2024-02-09'),
(15,15,15,5,'Fantastic product','2024-02-12'),
(16,16,17,4,'Good performance','2024-02-15'),
(17,17,18,3,'Decent quality','2024-02-18'),
(18,18,16,5,'Loved it','2024-02-21'),
(19,19,19,4,'Pretty good','2024-02-24'),
(20,20,20,5,'Best purchase','2024-02-27');

select * from reviews

insert into discounts 
(discount_id, product_id, discount_percentage, start_date, end_date, description) values
(1,1,10,'2024-01-01','2024-01-10','New Year Discount'),
(2,2,15,'2024-01-05','2024-01-15','Festival Offer'),
(3,3,5,'2024-01-10','2024-01-20','Special Discount'),
(4,4,20,'2024-01-12','2024-01-22','Mega Sale'),
(5,5,12,'2024-01-15','2024-01-25','Seasonal Offer'),
(6,6,8,'2024-01-18','2024-01-28','Limited Time Offer'),
(7,7,25,'2024-02-01','2024-02-10','Big Discount'),
(8,8,10,'2024-02-05','2024-02-15','Customer Special'),
(9,9,18,'2024-02-08','2024-02-18','Valentine Offer'),
(10,10,7,'2024-02-10','2024-02-20','Flash Sale'),
(11,11,15,'2024-02-15','2024-02-25','Holiday Offer'),
(12,12,9,'2024-02-18','2024-02-28','Winter Discount'),
(13,13,20,'2024-03-01','2024-03-10','Spring Sale'),
(14,14,14,'2024-03-05','2024-03-15','Special Combo'),
(15,15,6,'2024-03-08','2024-03-18','Member Discount'),
(16,16,22,'2024-03-10','2024-03-20','Mega Weekend'),
(17,17,11,'2024-03-12','2024-03-22','Customer Festival'),
(18,18,16,'2024-03-15','2024-03-25','Season Offer'),
(19,19,13,'2024-03-18','2024-03-28','Limited Offer'),
(20,20,30,'2024-03-20','2024-03-30','Grand Clearance');

select * from discounts

insert into audit_logs (table_name, action_type, performed_by) values
('customers','INSERT','admin'),
('products','INSERT','admin'),
('sales','INSERT','system'),
('sales','UPDATE','manager'),
('inventory','UPDATE','admin'),
('purchases','INSERT','admin'),
('purchase_details','INSERT','system'),
('payments','INSERT','cashier'),
('returns','INSERT','manager'),
('return_details','INSERT','system'),
('employees','UPDATE','admin'),
('sales_targets','INSERT','manager'),
('advertisements','INSERT','marketing'),
('reviews','INSERT','customer_portal'),
('discounts','INSERT','admin'),
('products','UPDATE','admin'),
('customers','UPDATE','support_team'),
('inventory','UPDATE','system'),
('sales','DELETE','admin'),
('payments','UPDATE','cashier');

select * from audit_logs

alter table  employees add column age int;
select * from employees 

update  employees set age=25 where  employee_id=1
update  employees set age=45 where  employee_id=2
update  employees set age=28 where  employee_id=3
update  employees set age=34 where  employee_id=4
update  employees set age=46 where  employee_id=5
update  employees set age=23 where  employee_id=6
update  employees set age=38 where  employee_id=7
update  employees set age=40 where  employee_id=8
update  employees set age=29 where  employee_id=9
update  employees set age=22 where  employee_id=10
update  employees set age=35 where  employee_id=11
update  employees set age=27 where  employee_id=12
update  employees set age=36 where  employee_id=13
update  employees set age=45 where  employee_id=14
update  employees set age=39 where  employee_id=15
update  employees set age=42 where  employee_id=16
update  employees set age=31 where  employee_id=17
update  employees set age=30 where  employee_id=18
update  employees set age=37 where  employee_id=19
update  employees set age=33 where  employee_id=20


delete from branches where branch_name="mumbai navi" and city="navy mumbai"

-- comparison opreators --

select * from employees where employee_id=1
select role from employees where employee_id=10
select * from employees

select * from branches where branch_id>11
select manager_name from managers where manager_id>5
----- in using ----

select * from employees where employee_id in (11,12,13,14,15,16)
select * from managers where manager_id in(4,5,6,7,8,9)

---- limit ----

select * from sales limit 15
select * from customers limit 10
select * from employees limit 6

--- logical conditions --- 

select * from customers where customer_id=4 and age=27
select * from suppliers where supplier_name="arun kumar" and city="chennai"
select * from employees where employee_name="arun prasad" or age=34
select * from managers  where manager_id=3 or manager_name="akil"
select * from branches where branch_name="chennai central branch" or city="madurai"
select * from advertisements where not ad_title="New Year Sale" and ad_type="online"  
select * from advertisements where not ad_title="New Year Sale" and ad_type="TV"  

--- aggregate function ----

select count(salary) from employees
select max(salary) from managers
select avg(employee_id) from employees
select min(ad_type) from advertisements
select sum(age) from customers
select avg(salary) as temp from managers
select sum(salary) as temp from employees

---- order by ----
select * from employees order by salary desc 
select * from employees order by employee_id desc 
select * from employees order by employee_id asc 
select ad_type from advertisements order by ad_type desc
select supplier_name from suppliers order by supplier_name asc
select supplier_name from suppliers order by supplier_name desc

---- like ------
select * from employees where employee_name like "%A"
select * from employees where employee_name like "A%"
select * from managers where manager_name like "_______"
select * from employees where employee_name like "__________%A"

------ between ------

select * from managers where salary between 67000 and 82000
select * from employees where salary between 29000 and 42000

----- distinct ------

select distinct manager_name from managers
select distinct salary from employees
select distinct employee_name from employees

---- group by ------

select salary,count(*)
from managers
group by salary

select count(employee_id),salary 
from employees
group by salary

select max(salary)
from managers
group by salary

select max(branch_id),branch_name
from branches
group by branch_name

select avg(ad_title),ad_type
from advertisements
group by ad_type

select min(supplier_name),city
from suppliers 
group by city

----- group by ----

select salary,count(*)
from employees
group by salary
having count(*)>1

select salary,count(*)
from managers
group by salary
having count(*)>1

select employee_name,count(salary)
from employees
group by employee_name
having count(salary)

-----inner joins -----

-------Customer with Sales-----

SELECT s.sale_id,
       c.customer_name,
       s.sale_date,
       s.final_amount
FROM sales s
INNER JOIN customers c
ON s.customer_id = c.customer_id;


------Product with Category------

SELECT p.product_name,
       c.category_name,
       p.selling_price
FROM products p
INNER JOIN categories c
ON p.category_id = c.category_id;


-----Employee with Branch----

SELECT e.employee_name,
       b.branch_name,
       e.salary
FROM employees e
INNER JOIN branches b
ON e.branch_id=b.branch_id;

---------- Purchase with Supplier ------------

SELECT p.purchase_id,
       s.supplier_name,
       p.purchase_date,
       p.total_amount
FROM purchases p
INNER JOIN suppliers s
ON p.supplier_id=s.supplier_id;

-------------Payment with Customer--------

SELECT c.customer_name,
       p.payment_mode,
       p.amount_paid
FROM payments p
JOIN sales s
ON p.sale_id=s.sale_id
JOIN customers c
ON s.customer_id=c.customer_id;

----- Group by-------

-----Total Sales by Customer----

SELECT customer_id,
SUM(final_amount) AS TotalSales
FROM sales
GROUP BY customer_id;

----------Total Products by Category----------

SELECT category_id,
COUNT(*) AS TotalProducts
FROM products
GROUP BY category_id;

-------Employees by Branch------

SELECT branch_id,
COUNT(*) AS TotalEmployees
FROM employees
GROUP BY branch_id;

------Total Stock by Product----

SELECT product_id,
SUM(stock_quantity)
FROM inventory
GROUP BY product_id;

---Supplier Purchase Amount----

SELECT supplier_id,
SUM(total_amount)
FROM purchases
GROUP BY supplier_id;

-------group by having--------

------Customers spending more than 3000----

SELECT customer_id,
SUM(final_amount) AS Total
FROM sales
GROUP BY customer_id
HAVING SUM(final_amount)>3000;

--------Branches having more than 1 employee--------

SELECT branch_id,
COUNT(*) AS Employees
FROM employees
GROUP BY branch_id
HAVING COUNT(*)>=1;

------Categories having more than one product-----

SELECT category_id,
COUNT(*) AS Products
FROM products
GROUP BY category_id
HAVING COUNT(*)>1;

-----Suppliers whose purchases exceed 50000----

SELECT supplier_id,
SUM(total_amount) TotalPurchase
FROM purchases
GROUP BY supplier_id
HAVING SUM(total_amount)>50000;

-----------Customers with more than two sales--------

SELECT customer_id,
COUNT(*) AS SalesCount
FROM sales
GROUP BY customer_id
HAVING COUNT(*)>2;

----------View-----------

CREATE VIEW customer_sales AS
SELECT c.customer_name,
       s.sale_date,
       s.final_amount
FROM customers c
JOIN sales s
ON c.customer_id=s.customer_id;

select * from employees customer_sales

--------Product View-------

CREATE VIEW product_category AS
SELECT p.product_name,
       c.category_name,
       p.selling_price
FROM products p
JOIN categories c
ON p.category_id=c.category_id;

------Employee View----

CREATE VIEW employee_branch AS
SELECT e.employee_name,
       b.branch_name,
       e.salary
FROM employees e
JOIN branches b
ON e.branch_id=b.branch_id;

-------- subquery--------

------- Highest Paid Employee-------

SELECT *
FROM employees
WHERE salary=
(
SELECT MAX(salary)
FROM employees
);

--------Cheapest Product------

SELECT *
FROM products
WHERE selling_price=
(
SELECT MIN(selling_price)
FROM products
);

------Customers whose bill is above average------------

SELECT *
FROM sales
WHERE final_amount>
(
SELECT AVG(final_amount)
FROM sales
);

---Products costing more than average----

SELECT *
FROM products
WHERE selling_price>
(
SELECT AVG(selling_price)
FROM products
);

----Employees earning above average----

SELECT *
FROM employees
WHERE salary>
(
SELECT AVG(salary)
FROM employees
);

----Employees earning above average-----

SELECT *
FROM employees
WHERE salary>
(
SELECT AVG(salary)
FROM employees
);

------- Function -------

---Calculate GST----

DELIMITER $$

CREATE FUNCTION CalculateGST(price DECIMAL(10,2))
RETURNS DECIMAL(10,2)

DETERMINISTIC

BEGIN

RETURN price*0.18;

END$$

DELIMITER ;
--use---
SELECT product_name,
selling_price,
CalculateGST(selling_price)
FROM products;

------ store procedure-----

------------Customer Sales--------
DELIMITER $$

CREATE PROCEDURE CustomerSales(IN cid INT)

BEGIN

SELECT *
FROM sales
WHERE customer_id=cid;

END$$

DELIMITER ;

--------Product Details------

DELIMITER $$

CREATE PROCEDURE ProductDetails()

BEGIN

SELECT *
FROM products;

END$$

DELIMITER ;

----Trigger-----

------ Audit Product Insert ----

DELIMITER $$

CREATE TRIGGER product_insert_log

AFTER INSERT

ON products

FOR EACH ROW

BEGIN
INSERT INTO audit_logs(table_name,action_type,performed_by)

VALUES('products','INSERT','Admin');

END$$

DELIMITER ;

-----Inventory Update Trigger---

DELIMITER $$

CREATE TRIGGER inventory_update_log

AFTER UPDATE

ON inventory

FOR EACH ROW

BEGIN

INSERT INTO audit_logs(table_name,action_type,performed_by)

VALUES('inventory','UPDATE','Admin');

END$$

DELIMITER ;

------Window function-----

--------Rank Products by Price------

SELECT product_name,
selling_price,
RANK() OVER(ORDER BY selling_price DESC) AS ProductRank
FROM products;

------Dense Rank-----

SELECT employee_name,
salary,
DENSE_RANK() OVER(ORDER BY salary DESC) RankSalary
FROM employees;

-------Row Number------

SELECT customer_name,
city,
ROW_NUMBER() OVER(PARTITION BY city ORDER BY customer_name) RowNo
FROM customers;

-------Running Total------

SELECT sale_date,
final_amount,
SUM(final_amount)
OVER(ORDER BY sale_date) RunningTotal
FROM sales;

---Index---

------Create Index on Customer Name---

CREATE INDEX idx_customer_name
ON customers(customer_name);

---Product Name Index----

CREATE INDEX idx_product_name
ON products(product_name);

-----Sale Date Index-----

CREATE INDEX idx_payment_mode
ON payments(payment_mode);

---------Payment Mode Index--------

CREATE INDEX idx_payment_mode
ON payments(payment_mode);

-----Composite Index-------

CREATE INDEX idx_customer_date
ON sales(customer_id,sale_date);









