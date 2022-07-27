USE BikeSalesDWGroup4;
GO

-- Sales/profits/discounts/revenue (Song Ling)
  -- - Find for:
  --     - sales
  --     - qty
  -- - Group by:
  --     - items
  --     - discounts
  -- - Order by:
  --     - Best to worst total sales generated

SELECT f.product_id, p.product_name AS 'Product Name', p.list_price AS 'List Price', ROUND(SUM(f.sales), 2) AS 'Total Sales', ROUND(SUM(f.profit), 2) AS 'Total Profit', SUM(f.quantity) AS 'Quantity Sold', CONCAT(CAST(AVG(f.discount)*100 AS INT),'%') AS 'Average Discount'
FROM factTable f, productDim p
WHERE f.product_id = p.product_id
GROUP BY f.product_id, p.product_name, p.list_price
ORDER BY [Total Profit] DESC;

-- Sales/Staff/stores (Joaquin)
  -- - Find for:
  --     - staff that makes most money
  -- - Order by:
  --     - sales

SELECT (s.first_name + ' '+ s.last_name) 'Staff Name', ROUND(SUM(f.sales * f.discount), 2) 'Total Sales', f.store_id 'Store Code'
FROM factTable f, staffDim s
WHERE f.staff_id = s.staff_id
GROUP BY (s.first_name + ' '+ s.last_name), f.store_id
ORDER BY [Total Sales] DESC;
-- From here I can infer there are only 6 active staffs out of the 9, out of thesee 6 staffs, ST2 staffs have the most sales, followed by ST1 and finally ST3.

-- Sales/Seasons of Sales/time (Rachel)
  -- - Find for:
  --     - Seasons of Sales (Weekly)
  -- - Order by:
  --     - Sales

SELECT SUM(f.sales) AS 'Total Sales',t.Year, t.WeekOfYear AS 'Week Of Year', t.MonthName AS 'Month'
FROM factTable f, timeDim t
WHERE f.time_id = t.time_id
GROUP BY t.Year, t.WeekOfYear, t.MonthName
ORDER BY [Total Sales] DESC;

-- Sales/Orders/Customers (Cody)
  -- - Find for:
  --     - customer sales
  --     - qty of orders
  -- - Order by:
  --     - state
  --     - city
SELECT (c.first_name + ' '+ c.last_name) 'Customer Name', ROUND(SUM(f.sales * f.discount), 2) 'Total Sales', COUNT(f.order_id) 'Quantity of Items Bought', c.[state] 'State', c.city 'City'
FROM factTable f, customerDim c
WHERE f.customer_id = c.customer_id
GROUP BY (c.first_name + ' '+ c.last_name), c.[state], c.city
ORDER BY [Total Sales] DESC, c.[state], c.city;

-- Sales/Products/brands/categories/inventory/(Time?) (Team)
  -- - Find for:
  --     - Categories
  --     - Brands
  --     - Products
  -- - Order by:
  --     - sales / tc (show inventory)

-- compares sales over quantity sold and stock available
SELECT * FROM
(SELECT c.category_name AS 'Category Name', b.brand_name AS 'Brand Name', p.product_name AS 'Product Name', SUM(f.quantity) AS 'Quantity Sold', p.stock AS Stock, ROUND(SUM(f.sales), 2) AS 'Total Sales', ROUND(SUM(f.profit), 2) AS 'Total Profit', RANK() OVER (PARTITION BY c.category_name ORDER BY ROUND(SUM(f.sales), 2) DESC) AS [Ranking]
FROM factTable f, categoryDim c, brandDim b, productDim p
WHERE f.product_id = p.product_id AND p.category_id = c.category_id AND p.brand_id = b.brand_id
GROUP BY c.category_name, b.brand_name, p.product_name, p.stock) AS ranktable
WHERE ranking IN (1,2,3)
ORDER BY [Category Name] ,[Total Sales] DESC;