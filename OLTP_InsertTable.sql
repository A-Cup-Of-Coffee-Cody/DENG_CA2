USE [BikeSalesGroup4];
GO

-- Customer Table (Joaquin)


-- Orders Table (Joaquin)


-- Order items Table (Joaquin)


-- Stocks Table (Song Ling)
ALTER TABLE production.stocks NOCHECK CONSTRAINT ALL
BULK INSERT production.stocks
FROM 'C:\DAAA\Y2S1\DENG_CA2\Stocks.csv'
WITH (fieldterminator=',', rowterminator='\n')

-- Products Table (Song Ling)
ALTER TABLE production.products NOCHECK CONSTRAINT ALL
Declare @Products VARCHAR(max) 

SELECT @Products =  
  BulkColumn 
    FROM OPENROWSET(BULK 'C:\DAAA\Y2S1\DENG_CA2\products.json', SINGLE_BLOB) JSON 

INSERT INTO production.products 
  SELECT * FROM OpenJSON(@Products, '$')  
  WITH ( 
  product_id VARCHAR(10) '$.product_id', 
  product_name VARCHAR (255) '$.product_name', 
  brand_id VARCHAR(5) '$.brand_id', 
  category_id VARCHAR(5) '$.category_id', 
  model_year INT '$.model_year', 
  list_price DECIMAL(10, 2) '$.list_price')

-- Stores Table (Rachel)


-- Staff Table (Rachel)


-- Brand Table (Cody)


-- Categories Table (Cody)
