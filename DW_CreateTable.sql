CREATE DATABASE BikeSalesDWGroup4
GO
USE [BikeSalesDWGroup4];
GO

CREATE TABLE staffDim (
  staff_id VARCHAR(5) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(25) NOT NULL,
  active INT NOT NULL,
  manager_id VARCHAR(5) NOT NULL,
  PRIMARY KEY(staff_id)
);

CREATE TABLE orderDim (
  order_id VARCHAR(10) NOT NULL,
  order_status INT NOT NULL,  --  Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
  order_date DATE NOT NULL,
  required_date DATE NOT NULL,
  shipped_date DATE,
  PRIMARY KEY(order_id)
);

CREATE TABLE storeDim (
  store_id VARCHAR(5) NOT NULL,
  store_name VARCHAR(255) NOT NULL,
  phone VARCHAR(25) NOT NULL,
  email VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  [state] VARCHAR(10) NOT NULL,
  zip_code VARCHAR(5) NOT NULL,
  PRIMARY KEY(store_id)
);

CREATE TABLE customerDim (
  customer_id VARCHAR(10) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  phone VARCHAR(25),
  email VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(50) NOT NULL,
  [state] VARCHAR(25) NOT NULL,
  zip_code VARCHAR(5) NOT NULL,
  PRIMARY KEY(customer_id)
);

CREATE TABLE timeDim (
  time_id INT NOT NULL,
  [Date] DATETIME,
  [FullDateUSA] CHAR(10),-- Date in MM-dd-yyyy format
  [DayOfMonth] VARCHAR(2),
  -- Field will hold day number of Month
  [DaySuffix] VARCHAR(4),
  -- Apply suffix as 1st, 2nd ,3rd etc
  [DayName] VARCHAR(9),
  -- Contains name of the day, Sunday, Monday 
  [DayOfWeekUSA] CHAR(1),-- First Day Sunday=1 and Saturday=7
  [DayOfYear] VARCHAR(3),
  [WeekOfMonth] VARCHAR(1),-- Week Number of Month 
  [WeekOfQuarter] VARCHAR(2),
  --Week Number of the Quarter
  [WeekOfYear] VARCHAR(2),--Week Number of the Year
  [Month] VARCHAR(2),
  --Number of the Month 1 to 12
  [MonthName] VARCHAR(9),--January, February etc
  [MonthOfQuarter] VARCHAR(2),-- Month Number belongs to Quarter
  [Quarter] CHAR(1),
  [QuarterName] VARCHAR(9),--First,Second..
  [Year] CHAR(4),-- Year value of Date stored in Row
  [YearName] CHAR(7),
  --CY 2012,CY 2013
  [MonthYear] CHAR(10),
  --Jan-2013,Feb-2013
  [MMYYYY] CHAR(6),
  [FirstDayOfMonth] DATE,
  [LastDayOfMonth] DATE,
  [FirstDayOfQuarter] DATE,
  [LastDayOfQuarter] DATE,
  [FirstDayOfYear] DATE,
  [LastDayOfYear] DATE,
  [IsWeekday] BIT,-- 0=Week End ,1=Week Day
  PRIMARY KEY(time_id)
);

CREATE TABLE categoryDim (
  category_id VARCHAR(5) NOT NULL,
  category_name VARCHAR(255) NOT NULL,
  PRIMARY KEY(category_id)
);

CREATE TABLE brandDim (
  brand_id VARCHAR(5) NOT NULL,
  brand_name VARCHAR(255) NOT NULL,
  PRIMARY KEY(brand_id)
);

CREATE TABLE productDim (
  product_id VARCHAR(10) NOT NULL,
  stock INT NOT NULL,
  brand_id VARCHAR(5) NOT NULL,
  category_id VARCHAR(5) NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  model_year INT NOT NULL,
  list_price DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY(product_id),
  FOREIGN KEY (brand_id) REFERENCES brandDim(brand_id),
  FOREIGN KEY (category_id) REFERENCES categoryDim(category_id)
);

CREATE TABLE factTable (
  staff_id VARCHAR(5) NOT NULL,
  order_id VARCHAR(10) NOT NULL,
  customer_id VARCHAR(10) NOT NULL,
  product_id VARCHAR(10) NOT NULL,
  time_id INT NOT NULL,
  store_id VARCHAR(5) NOT NULL,
  discount FLOAT,
  sales MONEY,
  profit MONEY,
  PRIMARY KEY(staff_id, order_id, customer_id, product_id, time_id, store_id),
  FOREIGN KEY (staff_id) REFERENCES staffDim(staff_id),
  FOREIGN KEY (order_id) REFERENCES orderDim(order_id),
  FOREIGN KEY (customer_id) REFERENCES customerDim(customer_id),
  FOREIGN KEY (product_id) REFERENCES productDim(product_id),
  FOREIGN KEY (time_id) REFERENCES timeDim(time_id),
  FOREIGN KEY (store_id) REFERENCES storeDim(store_id)
);