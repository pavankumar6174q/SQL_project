
-- EASY QUERIES


-- RETRIEVE THE TOTAL NUMBER OF ORDERS PLACED

SELECT COUNT(ORDER_ID)
 FROM ORDERS;


-- CALCULATE THE TOTAL REVENUE GENERATED FROM PIZZA SALES
SELECT Round(SUM(pizzas.PRICE * orders_details.quantity),2) AS tOTAL_SALES
FROM orders_details JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id;

-- IDENTIFY THE HIGHEST PRICED PIZZA 
Select pizza_types.name,pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- IDENTIFY THE MOST COMMON PIZZA SIZE ORDERED
-- SELECT QUANTITY, COUNT(order_details_ID) FROM orders_details GROUP BY quantity; 
SELECT pizzas.size, count(orders_details.order_details_id) as common_sizes
from pizzas join orders_details 
on pizzas.pizza_id = orders_details.pizza_id
group by pizzas.size
order by common_sizes desc limit 1;

-- LIST THE TOP 5 MOST ORDERED PIZZA TYPES ALONG WITH THEIR QUANTITIES
SELECT  pizza_types.name, count(orders_details.quantity) as quantity_ordered
from pizzas join pizza_types
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizza_types.name
order by quantity_ordered desc limit 5;	




