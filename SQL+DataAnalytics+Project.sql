create database puzzahut;
use pizzahut;
create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id));

create table orders_details(
   order_details_id int not null,
   order_id int not null,
   pizza_id text not null,
   quantity int not null,
   primary key(order_details_id));
   
-- RETRIEVE THE TOTAL NUMBER OF ORDERS PLACED
SELECT 
    COUNT(order_id) AS Total_Orders
FROM
    orders;

-- CALCULATE TOTAL REVENUE GENERATED FROM PIZZA SALES
SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS Total_Sales
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id;

-- IDENTIFY HIGHEST PRICED PIZZA
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- IDENTIFY THE MOST COMMON PIZZA SIZE/QUANTITY ORDERED
SELECT 
    pizzas.size,
    COUNT(orders_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- LIST THE TOP 5 MOST ORDERED PIZZA TYPES ALONG WITH THEIR QUANTITIES
SELECT 
    pizza_types.name, SUM(orders_details.quantity) AS Quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Quantity DESC
LIMIT 5;

-- JOIN THE NECESSARY TABLES TO FIND THE TOTAL QUANTITY OF EACH PIZZA CATEGORY OREDERED.
SELECT 
    pizza_types.category,
    SUM(orders_details.quantity) AS Quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Quantity DESC;

-- DETERMINE THE DISTRIBUTION OF ORDERS BY HOUR OF THE DAY.
SELECT 
    HOUR(order_time) AS Hours, COUNT(order_id) AS Order_Counts
FROM
    orders
GROUP BY Hours;

-- JOIN THE RELEVANT TABLES TO FIND THE CATEGORY WISE DISTRIBUTION OF PIZZAS
SELECT 
    pizza_types.category AS Category, COUNT(name)
FROM
    pizza_types
GROUP BY Category;

-- GROUP THE ORDERS BY DATE AND CALCULATE THE AVERAGE NUMBER OF PIZZAS ORDERED PER DAY

SELECT 
    ROUND(AVG(Total_Orders_of_the_Day), 2)
FROM
    (SELECT 
        orders.order_date AS Dates,
            SUM(orders_details.quantity) AS Total_Orders_of_the_Day
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY Dates) AS Daily_Quantity;

-- DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPES BASED ON REVENUE
SELECT 
    pizza_types.name,
    SUM(orders_details.quantity * pizzas.price) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue
LIMIT 3;

-- CALCULATE THE PERCENTAGE CONTRIBUTION OF EACH PIZZA TYPE TO TOTAL REVENUE

SELECT 
    pizza_types.category,
    ROUND(SUM(orders_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS Total_Sales
                FROM
                    orders_details
                        JOIN
                    pizzas ON pizzas.pizza_id = orders_details.pizza_id) * 100, 2) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Revenue DESC;

-- ANALYZE THE CUMULATIVE REVENUE GENERATED OVER TIME

SELECT 
      order_date, 
      SUM(Revenue) OVER (ORDER BY order_date) AS cum_revenue
FROM (
      SELECT 
          orders.order_date, 
          SUM(orders_details.quantity *pizzas.price) AS Revenue
FROM orders_details 
JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
JOIN orders ON orders.order_id = orders_details.order_id
GROUP BY orders.order_date
) AS Sales;


-- DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPE BASE ON REVENUE FOR EACH PIZZA CATEGORY

SELECT name, revenue 
FROM (SELECT 
        category, name, revenue, RANK() OVER (PARTITION BY category ORDER BY revenue DESC) 
        AS rn FROM ( SELECT 
            pizza_types.category, 
            pizza_types.name, 
            SUM(orders_details.quantity * pizzas.price) AS revenue
        FROM pizza_types 
        JOIN pizzas 
            ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN orders_details 
            ON orders_details.pizza_id = pizzas.pizza_id
        GROUP BY pizza_types.category, 
            pizza_types.name ) AS a ) AS b WHERE rn <= 3;


