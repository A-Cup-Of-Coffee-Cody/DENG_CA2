-- Customer ETL (Joaquin)
-- ! Delete before submission
ALTER TABLE BikeSalesDWGroup4.dbo.customerDim NOCHECK CONSTRAINT ALL;

DELETE FROM BikeSalesDWGroup4.dbo.customerDim;
-- Insert statement here --
SELECT COUNT(*) AS 'customerDim'
FROM BikeSalesDWGroup4.dbo.customerDim;

-- Order ETL (Joaquin)
-- ! Delete before submission
ALTER TABLE BikeSalesDWGroup4.dbo.orderDim NOCHECK CONSTRAINT ALL;

DELETE FROM BikeSalesDWGroup4.dbo.orderDim;
-- Insert statement here --
SELECT COUNT(*) AS 'orderDim'
FROM BikeSalesDWGroup4.dbo.orderDim;

-- Product ETL (Song Ling)
-- ! Delete before submission
ALTER TABLE BikeSalesDWGroup4.dbo.productDim NOCHECK CONSTRAINT ALL;

DELETE FROM BikeSalesDWGroup4.dbo.productDim;

INSERT INTO 
  BikeSalesDWGroup4.dbo.productDim
  (product_id, stock, brand_id, category_id, product_name, model_year, list_price)
SELECT
  p.product_id, SUM(s.quantity), p.brand_id, p.category_id, p.product_name, p.model_year, p.list_price
FROM
  BikeSalesGroup4.production.products p, BikeSalesGroup4.production.stocks s
WHERE p.product_id = s.product_id
GROUP BY p.product_id, p.brand_id, p.category_id, p.product_name, p.model_year, p.list_price;

SELECT COUNT(*) AS 'ProductDim'
FROM BikeSalesDWGroup4.dbo.productDim;
-- 313

-- Staff ETL (Rachel)
-- ! Delete before submission
ALTER TABLE BikeSalesDWGroup4.dbo.staffDim NOCHECK CONSTRAINT ALL;

DELETE FROM BikeSalesDWGroup4.dbo.staffDim;

INSERT INTO 
  BikeSalesDWGroup4.dbo.staffDim
  (staff_id, first_name, last_name, email, phone, active, manager_id)
SELECT
  staff_id, first_name, last_name, email, phone, active, manager_id
FROM
  BikeSalesGroup4.sales.staffs

SELECT COUNT(*) AS 'staffDim'
FROM BikeSalesDWGroup4.dbo.staffDim;

-- Store ETL (Rachel)
-- ! Delete before submission
ALTER TABLE BikeSalesDWGroup4.dbo.storeDim NOCHECK CONSTRAINT ALL;

DELETE FROM BikeSalesDWGroup4.dbo.storeDim;

INSERT INTO 
  BikeSalesDWGroup4.dbo.storeDim
  (store_id, store_name, phone, email, street, city, state, zip_code)
SELECT
  store_id, store_name, phone, email, street, city, state, zip_code
FROM
  BikeSalesGroup4.sales.stores

SELECT COUNT(*) AS 'storeDim'
FROM BikeSalesDWGroup4.dbo.storeDim;

-- Brand ETL (Cody)
-- ! Delete before submission
ALTER TABLE BikeSalesDWGroup4.dbo.brandDim NOCHECK CONSTRAINT ALL;

DELETE FROM BikeSalesDWGroup4.dbo.brandDim;

INSERT INTO 
  BikeSalesDWGroup4.dbo.brandDim
  (brand_id, brand_name)
SELECT
  brand_id, brand_name
FROM
  BikeSalesGroup4.production.brands

SELECT COUNT(*) AS 'brandDim'
FROM BikeSalesDWGroup4.dbo.brandDim;
-- 9

-- Category ETL (Cody)
-- ! Delete before submission
ALTER TABLE BikeSalesDWGroup4.dbo.categoryDim NOCHECK CONSTRAINT ALL;

DELETE FROM BikeSalesDWGroup4.dbo.categoryDim;

INSERT INTO 
  BikeSalesDWGroup4.dbo.categoryDim
  (category_id, category_name)
SELECT
  category_id, category_name
FROM
  BikeSalesGroup4.production.categories

SELECT COUNT(*) AS 'categoryDim'
FROM BikeSalesDWGroup4.dbo.categoryDim;
-- 7

DROP TABLE BikeSalesDWGroup4.dbo.factTable;
DROP TABLE BikeSalesDWGroup4.dbo.productDim;
DROP TABLE BikeSalesDWGroup4.dbo.customerDim;
DROP TABLE BikeSalesDWGroup4.dbo.orderDim;
DROP TABLE BikeSalesDWGroup4.dbo.staffDim;
DROP TABLE BikeSalesDWGroup4.dbo.storeDim;
DROP TABLE BikeSalesDWGroup4.dbo.brandDim;
DROP TABLE BikeSalesDWGroup4.dbo.categoryDim;
DROP TABLE BikeSalesDWGroup4.dbo.timeDim;