DELETE FROM BikeSalesDWGroup4.dbo.factTable;
DELETE FROM BikeSalesDWGroup4.dbo.timeDim;
DELETE FROM BikeSalesDWGroup4.dbo.productDim;
DELETE FROM BikeSalesDWGroup4.dbo.brandDim;
DELETE FROM BikeSalesDWGroup4.dbo.categoryDim;
DELETE FROM BikeSalesDWGroup4.dbo.customerDim;
DELETE FROM BikeSalesDWGroup4.dbo.storeDim;
DELETE FROM BikeSalesDWGroup4.dbo.orderDim;
DELETE FROM BikeSalesDWGroup4.dbo.staffDim;

-- Staff ETL
INSERT INTO 
  BikeSalesDWGroup4.dbo.staffDim
  (staff_id, first_name, last_name, email, phone, active, manager_id)
SELECT
  staff_id, first_name, last_name, email, phone, active, manager_id
FROM
  BikeSalesGroup4.sales.staffs

SELECT COUNT(*) AS 'staffDim'
FROM BikeSalesDWGroup4.dbo.staffDim;
--10

-- Order ETL
INSERT INTO 
  BikeSalesDWGroup4.dbo.orderDim
  (order_id, order_status, order_date, required_date, shipped_date)
SELECT
  o.order_id, o.order_status, o.order_date, o.required_date, o.shipped_date
FROM
  BikeSalesGroup4.sales.orders o
  
SELECT COUNT(*) AS 'orderDim'
FROM BikeSalesDWGroup4.dbo.orderDim;
-- 1615

-- Store ETL
INSERT INTO 
  BikeSalesDWGroup4.dbo.storeDim
  (store_id, store_name, phone, email, street, city, state, zip_code)
SELECT
  store_id, store_name, phone, email, street, city, state, zip_code
FROM
  BikeSalesGroup4.sales.stores

SELECT COUNT(*) AS 'storeDim'
FROM BikeSalesDWGroup4.dbo.storeDim;
-- 3

-- Customer ETL
INSERT INTO 
  BikeSalesDWGroup4.dbo.customerDim
  (customer_id, first_name, last_name, phone, email, street, city, [state], zip_code)
SELECT
  c.customer_id, c.first_name, c.last_name, c.phone, c.email, c.street, c.city, c.state, c.zip_code
FROM
  BikeSalesGroup4.sales.customers c


SELECT COUNT(*) AS 'customerDim'
FROM BikeSalesDWGroup4.dbo.customerDim;
-- 1445

-- Category ETL
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

-- Brand ETL
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

-- Product ETL
INSERT INTO 
  BikeSalesDWGroup4.dbo.productDim
  (product_id, stock, brand_id, category_id, product_name, model_year, list_price)
SELECT
  p.product_id, SUM(s.quantity), p.brand_id, p.category_id, p.product_name, p.model_year, p.list_price
FROM
  BikeSalesGroup4.production.products p, BikeSalesGroup4.production.stocks s
WHERE p.product_id = s.product_id
GROUP BY p.product_id, p.brand_id, p.category_id, p.product_name, p.model_year, p.list_price;

INSERT INTO 
  BikeSalesDWGroup4.dbo.productDim
  (product_id, stock, brand_id, category_id, product_name, model_year, list_price)
SELECT
  product_id, 0 AS stock, brand_id, category_id, product_name, model_year, list_price
FROM
  BikeSalesGroup4.production.products
WHERE product_id NOT IN (SELECT product_id FROM BikeSalesGroup4.production.stocks);

SELECT COUNT(*) AS 'productDim'
FROM BikeSalesDWGroup4.dbo.productDim;
-- 321

--DROP TABLE BikeSalesDWGroup4.dbo.factTable;
--DROP TABLE BikeSalesDWGroup4.dbo.productDim;
--DROP TABLE BikeSalesDWGroup4.dbo.customerDim;
--DROP TABLE BikeSalesDWGroup4.dbo.orderDim;
--DROP TABLE BikeSalesDWGroup4.dbo.staffDim;
--DROP TABLE BikeSalesDWGroup4.dbo.storeDim;
--DROP TABLE BikeSalesDWGroup4.dbo.brandDim;
--DROP TABLE BikeSalesDWGroup4.dbo.categoryDim;
--DROP TABLE BikeSalesDWGroup4.dbo.timeDim;