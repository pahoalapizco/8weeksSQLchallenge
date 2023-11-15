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

-- q9: What was the total volume of pizzas ordered for each hour of the day? 
-- Solución 1: Incluye solo las horas regisitradas en la BBDD 
SELECT HOUR(order_time) AS `hour`, COUNT(HOUR(order_time)) AS volume
FROM customer_orders
GROUP BY HOUR(order_time)
ORDER BY `hour`;

-- Solución 2: Incluye las 24 horas del día
DROP TABLE IF EXISTS hours;
CREATE TEMPORARY TABLE hours (
	hour_of_day TIME
);

INSERT INTO hours (hour_of_day)
VALUES (TIME('00')), (TIME('01:00:00')),(TIME('02:00:00')),(TIME('03:00:00')),(TIME('04:00:00')),(TIME('05:00:00')),(TIME('06:00:00')),(TIME('07:00:00')),(TIME('08:00:00')),(TIME('09:00:00')),(TIME('10:00:00')),(TIME('11:00:00')),
	   (TIME('12:00:00')), (TIME('13:00:00')),(TIME('14:00:00')),(TIME('15:00:00')),(TIME('16:00:00')),(TIME('17:00:00')),(TIME('18:00:00')),(TIME('19:00:00')),(TIME('20:00:00')),(TIME('21:00:00')),(TIME('22:00:00')),(TIME('23:00:00'));

SELECT H.hour_of_day, COUNT(C.pizza_id) AS Volumne
FROM customer_orders AS C
	RIGHT JOIN hours H ON HOUR(H.hour_of_day) = HOUR(C.order_time)
GROUP BY H.hour_of_day
ORDER BY H.hour_of_day;

-- q10: What was the volume of orders for each day of the week?
SELECT WEEKDAY(order_time) AS `day`, DAYNAME(order_time) AS daye_name, COUNT(DAY(order_time)) AS volume
FROM customer_orders
GROUP BY WEEKDAY(order_time), DAYNAME(order_time)
ORDER BY `day`;

