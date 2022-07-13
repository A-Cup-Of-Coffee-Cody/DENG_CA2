USE [BikeSalesGroup4];
GO

-- Customer Table (Joaquin)
-- ! Delete before Continuing to Data Warehouse
ALTER TABLE sales.customers NOCHECK CONSTRAINT ALL

SELECT COUNT(*) FROM sales.customers; -- 1445

-- Orders Table (Joaquin)
-- ! Delete before Continuing to Data Warehouse
ALTER TABLE sales.orders NOCHECK CONSTRAINT ALL

SELECT COUNT(*) FROM sales.orders; -- 1615

-- Order items Table (Joaquin)
-- ! Delete before Continuing to Data Warehouse
ALTER TABLE sales.order_items NOCHECK CONSTRAINT ALL

SELECT COUNT(*) FROM sales.order_items; -- 4722


-- Stocks Table (Song Ling)
-- ! Delete before Continuing to Data Warehouse
ALTER TABLE production.stocks NOCHECK CONSTRAINT ALL

BULK INSERT production.stocks
FROM 'C:\DAAA\Y2S1\DENG_CA2\Stocks.csv'
WITH (firstrow = 2, fieldterminator=',', rowterminator='\n')

SELECT COUNT(*) FROM production.stocks; -- 939

-- Products Table (Song Ling)
-- ! Delete before Continuing to Data Warehouse
ALTER TABLE production.products NOCHECK CONSTRAINT ALL

Declare @Products VARCHAR(max) 

SELECT @Products =  
  BulkColumn 
    FROM OPENROWSET(BULK 'C:\DAAA\Y2S1\DENG_CA2\products.json', SINGLE_BLOB) JSON 

INSERT INTO production.products 
  SELECT COUNT(*) FROM OpenJSON(@Products, '$')  
  WITH ( 
  product_id VARCHAR(10) '$.product_id', 
  product_name VARCHAR (255) '$.product_name', 
  brand_id VARCHAR(5) '$.brand_id', 
  category_id VARCHAR(5) '$.category_id', 
  model_year INT '$.model_year', 
  list_price DECIMAL(10, 2) '$.list_price')

SELECT COUNT(*) FROM production.products; -- 321

-- Stores Table (Rachel)
-- ! Delete before Continuing to Data Warehouse
ALTER TABLE sales.stores NOCHECK CONSTRAINT ALL

SELECT COUNT(*) FROM sales.stores; -- 3

-- Staff Table (Rachel)
-- ! Delete before Continuing to Data Warehouse
ALTER TABLE sales.staffs NOCHECK CONSTRAINT ALL

SELECT COUNT(*) FROM sales.staffs; -- 10

-- Brand Table (Cody)
-- ! Delete before Continuing to Data Warehouse
ALTER TABLE production.brands NOCHECK CONSTRAINT ALL
BULK INSERT production.brands
FROM 'C:\DENG_CA2\Brand.txt'
WITH (fieldterminator='\t', rowterminator='\n')

SELECT COUNT(*) FROM production.brands; -- 9

-- Categories Table (Cody)
-- ! Delete before Continuing to Data Warehouse
ALTER TABLE production.categories NOCHECK CONSTRAINT ALL
BULK INSERT production.categories
FROM 'C:\DENG_CA2\Category.txt'
WITH (fieldterminator='\t', rowterminator='\n')

SELECT COUNT(*) FROM production.categories; -- 7
