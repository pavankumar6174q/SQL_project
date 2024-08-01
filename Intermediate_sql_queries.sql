-- INTERMEDIATE QUERIES

-- TOTAL QUANTITY OF EACH PIZZA category

select pizza_types.category, count(orders_details.quantity) as Quantity_ordered
from pizzas
join pizza_types 
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizza_types.category
order by Quantity_ordered desc;


--  DETERMINE THE DISTRIBUTION OF ORDERS BY HOURS OF THE DAY
SELECT HOUR(order_time) as hour, 
count(order_id) as order_at_that_time from orders
group by hour;


-- CATEGORY WISE DISTRIBUTION OF PIZZAS

SELECT category, count(name) as Pizza_Types from pizza_types
group by category; 



-- GROUP THE ORDERS BY DATE AND CALCULATE THE AVG NO OF PIZZAS ORDERED PER DAY
select round(avg(quantity),0) as Average_Pizzas_per_day from
(SELECT orders.order_date, sum(orders_details.quantity) as quantity
from orders join orders_details
on orders.order_id = orders_details.order_id
group by orders.order_date) as order_quantity;



-- DETERMINE THE TOP 3 MOST ORDERED PIZZA BASED ON THE REVENUE
Select pizza_types.name,
sum(pizzas.price * orders_details.quantity) as order_value
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by order_value desc limit 3;



