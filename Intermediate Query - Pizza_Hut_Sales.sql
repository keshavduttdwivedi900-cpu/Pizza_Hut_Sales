-- --Intermediate
-- 1.Join  the necessary tables to find the total quantity of each pizza category ordered.
select * from pizza_types;


select pt.category,sum(o.quantity)
from order_details o
join pizzas p on o.pizza_id = p.pizza_id
join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by pt.category
order by sum(o.quantity) desc

-- 2.Determine the distribution of orders by hour of the day.
select hour(order_time) as hour,count(order_id) as order_count
from orders
group by hour(order_time);

-- 3)Join relevant tables to find the category wise distribution of pizzas.
select category,count(name) from pizza_types
group by category

-- 4)Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity),0) from 
(select o.order_date,sum(od.quantity) as quantity
from orders o
join order_details od on od.order_id = o.order_id
group by o.order_date) as order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.

select round(sum(od.quantity * p.price ),0) as revenue,pt.name
from order_details od
join pizzas p on od.pizza_id = p.pizza_id
join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by pt.name
order by revenue desc
limit 3










