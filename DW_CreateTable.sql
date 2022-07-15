CREATE DATABASE BikeSalesDWGroup4
GO
USE [BikeSalesDWGroup4];
GO

CREATE TABLE staffDim (
	staff_id int NOT NULL,
	active int NOT NULL,
	phone int NOT NULL,
	email varchar(30) NOT NULL,
	first_name varchar(10) NOT NULL,
	last_name varchar(10) NOT NULL,
	manager_id int NOT NULL,
	PRIMARY KEY(staff_id),
);

CREATE TABLE orderDim(
	order_id int NOT NULL,
	order_date date NOT NULL,
--  Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_status int NOT NULL,
	required_date date NOT NULL,
	shipped_date date,
	PRIMARY KEY(order_id),
);

CREATE TABLE storeDim(
	store_id int NOT NULL,
	store_name varchar(10) NOT NULL,
	phone int NOT NULL,
	email varchar(30) NOT NULL,
	city varchar(20) NOT NULL,
	zip_code int NOT NULL,
	[state] varchar(30) NOT NULL,
	street varchar(30) NOT NULL,
	PRIMARY KEY(store_id),
);

CREATE TABLE customerDim(
	customer_id int NOT NULL,
	phone int NOT NULL,
	email varchar(30) NOT NULL,
	first_name varchar(10) NOT NULL,
	last_name varchar(10) NOT NULL,
	city varchar(20) NOT NULL,
	zip_code int NOT NULL,
	[state] varchar(30) NOT NULL,
	street varchar(30) NOT NULL,
	PRIMARY KEY(customer_id),
);

CREATE TABLE timeDim(
	time_no int NOT NULL, -- are we gonna put this as identity since time_no is not present in our OLTP?
	[Month] int NOT NULL,
	[quarter] int NOT NULL,
	[year] int NOT NULL,
	day_of_week varchar(10) NOT NULL,
	PRIMARY KEY(time_no),
);

CREATE TABLE brandDim(
	brand_id int NOT NULL,
	brand_name varchar(20) NOT NULL,
	PRIMARY KEY(brand_id),
);

CREATE TABLE categoryDim(
	category_id int NOT NULL,
	category_name varchar(20) NOT NULL,
	PRIMARY KEY(category_id),
);

CREATE TABLE productDim(
	product_id int NOT NULL,
	stock_id int NOT NULL,
	brand_id int NOT NULL,
	category_id int NOT NULL,
	product_name varchar(20) NOT NULL,
	model_year int NOT NULL,
	list_price varchar(10) NOT NULL,
	shipped_date date,
	PRIMARY KEY(product_id),
	FOREIGN KEY (brand_id) REFERENCES brandDim(brand_id),
	FOREIGN KEY (category_id) REFERENCES categoryDim(category_id),
);

CREATE TABLE factTable(
	staff_id int NOT NULL,
	order_id int NOT NULL,
	customer_id int NOT NULL,
	product_id int NOT NULL,
	time_no int NOT NULL,
	store_id int NOT NULL,
-- discount, sales and profit, what datatypes do we set?
	discount int,
	sales int,
	profit int,
	PRIMARY KEY(staff_id, order_id, customer_id, product_id, time_no, store_id),
	FOREIGN KEY (staff_id) REFERENCES staffDim(staff_id),
	FOREIGN KEY (order_id) REFERENCES orderDim(order_id),
	FOREIGN KEY (customer_id) REFERENCES customerDim(customer_id),
	FOREIGN KEY (product_id) REFERENCES productDim(product_id),
	FOREIGN KEY (time_no) REFERENCES timeDim(time_no),
	FOREIGN KEY (store_id) REFERENCES storeDim(store_id),
);
