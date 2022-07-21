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


-- Sales/Staff/stores (Joaquin)
  -- - Find for:
  --     - staff that makes most money
  -- - Order by:
  --     - sales
select * from factTable
select * from staffDim

SELECT (s.first_name + ' '+ s.last_name) 'Staff Name', SUM(f.sales * f.discount) 'Total Sales'
FROM factTable f, staffDim s
WHERE f.staff_id = s.staff_id
GROUP BY s.first_name + ' '+ s.last_name

select count(staff_id)
from factTable
-- Sales/Seasons of Sales/time (Rachel)
  -- - Find for:
  --     - Seasons of Sales (Weekly)
  -- - Order by:
  --     - Sales


-- Sales/Orders/Customers (Cody)
  -- - Find for:
  --     - customer sales
  --     - qty of orders
  -- - Order by:
  --     - state
  --     - city


-- Sales/Products/brands/categories/inventory/(Time?) (Team)
  -- - Find for:
  --     - Categories
  --     - Brands
  --     - Products
  -- - Order by:
  --     - sales / tc (show inventory)