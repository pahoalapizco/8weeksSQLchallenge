USE pizza_runner;

-- q1: How many pizzas were ordered?
-- 14 Pizzas ha sido ordenadas por los clientes de pizza runner
SELECT COUNT(*) AS total_orders
FROM customer_orders;

-- q2: How many unique customer orders were made?
-- De las 14 ordenes totales, 4 estan incluidas dentro las 10 ordnes unicas (1 orden tiene más de un producto)
SELECT COUNT(DISTINCT order_id) AS total_unique_orders
FROM customer_orders;

-- q3: How many successful orders were delivered by each runner?
SELECT runner_id, COUNT(runner_id) AS successful_deliveries
FROM runner_orders
WHERE cancelation IS NULL
GROUP BY runner_id
ORDER BY runner_id ASC;

-- q4: How many of each type of pizza was delivered?
SELECT PN.pizza_name, COUNT(C.pizza_id) AS Total
FROM runner_orders AS R
	INNER JOIN customer_orders AS C ON C.order_id = R.order_id
	INNER JOIN pizza_names AS PN ON PN.pizza_id = C.pizza_id
WHERE R.cancelation IS NULL
GROUP BY PN.pizza_name;

-- q5: How many Vegetarian and Meatlovers were ordered by each customer?
SELECT C.customer_id, PN.pizza_name, COUNT(C.pizza_id) AS total_pizzas
FROM customer_orders AS C
	INNER JOIN pizza_names AS PN ON PN.pizza_id = C.pizza_id
GROUP BY C.customer_id, PN.pizza_name
ORDER BY C.customer_id;

-- q6: What was the maximum number of pizzas delivered in a single order?
SELECT C.order_id, COUNT(C.pizza_id) AS total_pizzas 
FROM runner_orders AS R
	INNER JOIN customer_orders AS C ON C.order_id = R.order_id
WHERE R.cancelation IS NULL
GROUP BY C.order_id
ORDER BY total_pizzas DESC
LIMIT 1 ;

-- q7: For each customer, how many delivered pizzas had at least 1 change and how many had no changes? 
SELECT C.customer_id, 
	COUNT(CASE WHEN C.exclusions IS NOT NULL OR C.extras IS NOT NULL THEN 1 ELSE NULL END) AS total_with_changes, 
	COUNT(CASE WHEN C.exclusions IS NULL AND C.extras IS NULL THEN 1 ELSE NULL END) AS total_with_no_changes
FROM customer_orders AS C 
	INNER JOIN runner_orders AS R ON R.order_id = C.order_id AND R.cancelatioN IS NULL
GROUP BY C.customer_id;

-- q8: How many pizzas were delivered that had both exclusions and extras?
SELECT
	COUNT(C.pizza_id) AS total
FROM customer_orders AS C 
	INNER JOIN runner_orders AS R ON R.order_id = C.order_id AND R.cancelatioN IS NULL
WHERE C.exclusions IS NOT NULL AND C.extras IS NOT NULL
GROUP BY C.customer_id;