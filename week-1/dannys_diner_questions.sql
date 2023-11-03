USE dannys_diner;

-- q1: What is the total amount each customer spent at the restaurant?
SELECT S.customer_id AS Curtomer, SUM(M.price) AS total_amount
FROM sales AS S
	INNER JOIN menu as M ON M.product_id = S.product_id
GROUP BY S.customer_id;

-- q2: How many days has each customer visited the restaurant?
-- A: 4, B: 6 C: 2,
SELECT S.customer_id, COUNT(DISTINCT order_date) AS total_days_visited
FROM sales AS S
GROUP BY S.customer_id
ORDER BY total_days_visited DESC;

-- q3: What was the first item from the menu purchased by each customer?
-- A: Sushi y Curry, B: Curry, C: Ramen
SELECT S.customer_id, S.order_date, M.product_name
FROM SALES  AS S
	INNER JOIN  menu AS M ON M.product_id = S.product_id
    INNER JOIN ( 
		SELECT MIN(order_date) AS first_date, customer_id 
		FROM Sales GROUP BY  customer_id
    ) AS T ON T.first_date = S.order_date AND T.customer_id = S.customer_id
GROUP BY  S.customer_id, S.order_date, M.product_name;






