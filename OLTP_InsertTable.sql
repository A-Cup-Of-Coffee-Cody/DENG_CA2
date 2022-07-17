USE [BikeSalesGroup4];
GO

-- Stores Table
DELETE FROM sales.stores;

BULK INSERT sales.stores
FROM 'C:\DAAA\Y2S1\DENG_CA2\Store.txt'
WITH (fieldterminator='\t', rowterminator='\n')

SELECT COUNT(*) AS 'Stores Table'
FROM sales.stores;
-- 3

-- Staff Table
DELETE FROM sales.staffs;

BULK INSERT sales.staffs
FROM 'C:\DAAA\Y2S1\DENG_CA2\Staff.txt'
WITH (fieldterminator='\t', rowterminator='\n')

SELECT COUNT(*) AS 'Staff Table'
FROM sales.staffs;
-- 10

-- Categories Table
DELETE FROM production.categories;

BULK INSERT production.categories
FROM 'C:\DAAA\Y2S1\DENG_CA2\Category.txt'
WITH (fieldterminator='\t', rowterminator='\n')

SELECT COUNT(*) AS 'Categories Table'
FROM production.categories;
-- 7

-- Brand Table
DELETE FROM production.brands;

BULK INSERT production.brands
FROM 'C:\DAAA\Y2S1\DENG_CA2\Brand.txt'
WITH (fieldterminator='\t', rowterminator='\n')

SELECT COUNT(*) AS 'Brand Table'
FROM production.brands;
-- 9

-- Products Table
DELETE FROM production.products;

Declare @Products VARCHAR(max)

SELECT @Products =  
  BulkColumn
FROM OPENROWSET(BULK 'C:\DAAA\Y2S1\DENG_CA2\products.json', SINGLE_BLOB) JSON

INSERT INTO production.products
SELECT *
FROM OpenJSON(@Products, '$')  
  WITH ( 
  product_id VARCHAR(10) '$.product_id', 
  product_name VARCHAR (255) '$.product_name', 
  brand_id VARCHAR(5) '$.brand_id', 
  category_id VARCHAR(5) '$.category_id', 
  model_year INT '$.model_year', 
  list_price DECIMAL(10, 2) '$.list_price');

SELECT COUNT(*) AS 'Products Table'
FROM production.products;
-- 321

-- Customer Table
DELETE FROM sales.customers;

BULK INSERT sales.customers
FROM 'C:\DAAA\Y2S1\DENG_CA2\customers.csv'
WITH (firstrow = 2, fieldterminator=',', rowterminator='\n')

SELECT COUNT(*) AS 'Customer Table'
FROM sales.customers;
-- 1445

-- Orders Table
DELETE FROM sales.orders;

SET DATEFORMAT DMY
BULK INSERT sales.orders
FROM 'C:\DAAA\Y2S1\DENG_CA2\Orders.csv'
WITH (firstrow = 2, fieldterminator=',', rowterminator='\n'	)

SELECT COUNT(*) AS 'Orders Table'
FROM sales.orders;
-- 1615

-- Order items Table
DELETE FROM sales.order_items;

BULK INSERT sales.order_items
FROM 'C:\DAAA\Y2S1\DENG_CA2\OrderItems.csv'
WITH (firstrow = 2, fieldterminator=',', rowterminator='\n')

SELECT COUNT(*) AS 'Order items Table'
FROM sales.order_items;
-- 4722

-- Stocks Table
DELETE FROM production.stocks;

BULK INSERT production.stocks
FROM 'C:\DAAA\Y2S1\DENG_CA2\Stocks.csv'
WITH (firstrow = 2, fieldterminator=',', rowterminator='\n')

SELECT COUNT(*) AS 'Stocks Table'
FROM production.stocks; -- 939