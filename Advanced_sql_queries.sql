-- ADVANCED QUERIES

-- CALCULATE THE PERCENTAGE CONTRIBUTION OF EACH PIZZA TYPE TO THE TOTAL REVENUE

Select pizza_types.category,
Round(sum(pizzas.price * orders_details.quantity)/ (SELECT Round(SUM(pizzas.PRICE * orders_details.quantity),2) AS tOTAL_SALES
FROM orders_details JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id ) *100,2) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizza_types.category
order by revenue desc;

-- CALCULATING THE CUMULATIVE TOTAL FOR THE PROFITS
select order_date,
round(sum(revenue) over (order by order_date), 2) as cum_revenue
from
(Select orders.order_date,
sum(pizzas.price * orders_details.quantity) as revenue
from orders_details join pizzas
on pizzas.pizza_id = orders_details.pizza_id
join orders
on orders.order_id = orders_details.order_id
group by orders.order_date
order by revenue) as sales;



-- DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPES BASED ON THEIR CATEGORY

select category ,name, revenue from 
(select category, name, revenue, 
rank() OVER( partition by category order by revenue) as ranks
from
(select pizza_types.category, pizza_types.name,
sum(pizzas.price * orders_details.quantity) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizza_types.category, pizza_types.name
order by revenue desc) as separate_values) as ranks
where ranks <= 3;

