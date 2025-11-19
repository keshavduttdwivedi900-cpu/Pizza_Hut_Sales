-- Advanced
-- Calculate the percentage contribution of each pizza type to total revenue

select pt.category,
round (sum(o.quantity * p.price)/(Select
    ROUND(SUM(o.quantity*p.price),
          2) as total_sales

from o 
join p on p.pizza_id = o.pizza_id)*100,2) as revenue



from pizza_types pt 
join pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details o on  o.pizza_id = p.pizza_id
group by pt.category 
order by revenue desc;

-- or

SELECT 
    pt.category,
    ROUND(
        (SUM(o.quantity * p.price) /
        (
            SELECT ROUND(SUM(od.quantity * pp.price), 2) 
            FROM order_details od
            JOIN pizzas pp ON od.pizza_id = pp.pizza_id
        ) * 100),
    2) AS revenue
FROM pizza_types pt
JOIN pizzas p 
    ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details o 
    ON o.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY revenue DESC;


-- 2.Analyze the cumulative revenue generated over time.

select o.order_date,
sum(revenue) over(order by order_date) as cum_revenue
from
(select o.order_date,
sum(od.quantity * p.price) as revenue

from order_details od 
join pizzas p on od.pizza_id = p.pizza_id
join orders o on o.order_id = od.pizza_id
group by o.order_date as sales;

--or

SELECT 
    sales.order_date,
    SUM(sales.revenue) OVER (ORDER BY sales.order_date) AS cum_revenue
FROM (
    SELECT 
        o.order_date,
        SUM(od.quantity * p.price) AS revenue
    FROM order_details od
    JOIN pizzas p 
        ON od.pizza_id = p.pizza_id
    JOIN orders o 
        ON o.order_id = od.order_id
    GROUP BY o.order_date
) AS sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category,name,revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select  pt.category,pt.name,
sum((od.quantity) * p.price) as revenue
from pizza_types pt
join pizzas p
on pt.pizza_type_id = p.pizza_type_id
join order_details od
on od.pizza_id = pizzas.pizza_id
group by pt.category,pt.name) as a;

-- or

select name,revenue from 
(SELECT category,name,revenue,
RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn
FROM (SELECT  pt.category,pt.name,SUM(od.quantity * p.price) AS revenue
FROM pizza_types pt JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category, pt.name) AS a) as b
where rn <= 3;





 
