Use pizzaDB

-- -- Verify the import
SELECT TOP 10 * FROM pizza_sales;
SELECT COUNT(*) AS TotalRows FROM pizza_sales;
GO

---------- KPIs ----------

----- Total revenue 
Select Format( Sum(total_price), 'C2') as Total_Revenue
From pizza_sales;


----- Average order price
Select Format( Sum(total_price) / Count(Distinct order_id), 'C2') as Average_order
From pizza_sales;

----- Total number of pizzas sold
Select  Format( Sum(quantity), 'N0')  as Pizzas_sold
From pizza_sales; 

----- Total number of orders
Select  Format( Count(Distinct order_id), 'N0')  as Orders
From pizza_sales; 


----- Average amount of pizzas per oder
Select  Format( 
	Cast(Sum(quantity) as Decimal(10,2)) /
	Cast(Count(Distinct order_id) as Decimal(10,2)), 'N2') as Avg_pizzas_order
From pizza_sales;




---------- Time Trends ----------


----- Orders over weekdays
Select  Datename(DW, order_date) as week_day
		, Format( Count(Distinct order_id), 'N0')  as total_daily_orders
From pizza_sales
Group by  Datename(DW, order_date)
ORder By 2 Desc;


----- Orders over months
Select  Datename(Month, order_date) as month_name
		, Format( Count(Distinct order_id), 'N0')  as total_monthly_orders
From pizza_sales
Group by  Datename(Month, order_date)
Order By 2 Desc;





---------- Other Statistics ----------


----- Sales by pizza type
Select Top 10 *
From pizza_sales;

Select pizza_category
		, Format( Sum(total_price), 'C2') as Total_Revenue
		, Format( 100*Sum(total_price) / ( Select Sum(total_price) From  pizza_sales ), 'N2') as PCT
From pizza_sales
Group by pizza_category
Order By 3 Desc;


----- Sales by pizza size
Select pizza_size
		, Format( Sum(total_price), 'C2') as Total_Revenue
		, Format( 100*Sum(total_price) / ( Select Sum(total_price) From  pizza_sales ), 'N2') as PCT
From pizza_sales
Group by pizza_size
Order By 3 Desc;

----- Quantity of pizzas sold  by category
Select pizza_category
		, Format( Sum(quantity), 'N0') as Total_Qnt_Sold
From pizza_sales
Group by pizza_category
Order By 2 Desc;

----- Top 5 best selling pizzas 
Select Top 5 pizza_name
		, Format( Sum(total_price), 'C2') as Total_Revenue
		, Sum(total_price) as Total_Revenue_order
From pizza_sales
Group by pizza_name
Order By 3 Desc;


-----  5 the worst selling pizzas 
Select Top 5 pizza_name
		, Format( Sum(total_price), 'C2') as Total_Revenue
		, Sum(total_price) as Total_Revenue_order
From pizza_sales
Group by pizza_name
Order By 3 Asc;


----- Top 5 best selling pizzas by quantity
Select Top 5 pizza_name
		, Format( Sum(quantity), 'N0') as Quantity
		, Sum(quantity) as Quantity_order
From pizza_sales
Group by pizza_name
Order By 3 Desc;


----- 5 the worst selling pizzas by quantity
Select Top 5 pizza_name
		, Format( Sum(quantity), 'N0') as Quantity
		, Sum(quantity) as Quantity_order
From pizza_sales
Group by pizza_name
Order By 3 Asc;