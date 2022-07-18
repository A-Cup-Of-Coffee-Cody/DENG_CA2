-- Fact Table ETL 
USE BikeSalesDWGroup4

INSERT INTO BikeSalesDWGroup4.dbo.factTable
(staff_id, order_id, customer_id, product_id, time_id, store_id, discount, sales, profit)
    
SELECT
 s.staff_id,
 o.order_id,
 c.customer_id,
 p.product_id, 
 replace(CONVERT(DATE,ord.order_date, 112),'-',''),
 st.store_id,
 oi.discount,
 (p.list_price * p.stock),
 (p.list_price * p.stock)	--To update profit

FROM 
BikeSalesGroup4.sales.[order_items] oi 
INNER JOIN BikeSalesGroup4.production.[products] pr ON oi.product_id = pr.product_id
INNER JOIN BikeSalesGroup4.sales.[orders] ord ON ord.order_id = oi.order_id
INNER JOIN BikeSalesDWGroup4.dbo.[staffDim] s ON ord.staff_id = s.staff_id
INNER JOIN BikeSalesDWGroup4.dbo.[orderDim] o ON oi.order_id = o.order_id
INNER JOIN BikeSalesDWGroup4.dbo.[customerDim] c ON ord.customer_id = c.customer_id
INNER JOIN BikeSalesDWGroup4.dbo.[productDim] p  ON pr.product_id = p.product_id
INNER JOIN BikeSalesDWGroup4.dbo.[storeDim] st  ON ord.store_id = st.store_id
