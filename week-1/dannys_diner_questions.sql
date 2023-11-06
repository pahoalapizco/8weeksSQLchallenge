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

-- q4: What is the most purchased item on the menu and how many times was it purchased by all customers?
-- Ramen es el producto más vendido del menú con un total de 8 ventas en total.
SELECT S.customer_id, M.product_name, COUNT(M.product_id) AS total
FROM sales AS S
	INNER JOIN menu AS M ON M.product_id = S.product_id
	INNER JOIN (SELECT product_id, COUNT(product_id) AS total
			FROM sales
			GROUP BY product_id
			ORDER BY total DESC
			LIMIT 1) AS T ON T.product_id = M.product_id
GROUP BY S.customer_id, M.product_name
ORDER BY total DESC, S.customer_id ASC;

-- q5: Which item was the most popular for each customer?
-- Para los clientes A y C el producto/platillo más popular es el ramen, sin embargo B a comprado por igual los 3 distintos platillos del menu.
SELECT S.customer_id, M.product_name
FROM SALES AS S
	INNER JOIN menu AS M ON M.product_id = S.product_id
    INNER JOIN (
		SELECT customer_id, product_id,
			RANK() OVER(PARTITION BY customer_id ORDER BY COUNT(product_id) DESC) AS ranking
		FROM sales
		GROUP BY customer_id, product_id
    ) AS T ON T.product_id = S.product_id AND T.customer_id = S.customer_id AND T.ranking = 1
GROUP BY S.customer_id, M.product_name
ORDER BY S.customer_id;

-- q6: Which item was purchased first by the customer after they became a member?
-- El primer platillo que compró el cliente A fue Ramen y B compró Sushi.
SELECT T.customer_id, T.product
FROM ( 
	SELECT MEM.customer_id,  M.product_name AS product,
		RANK() OVER(PARTITION BY M.product_name ORDER BY MIN(S.order_date) ASC) AS ranking
	FROM sales AS S
		INNER JOIN menu AS M ON M.product_id = S.product_id
		INNER JOIN members AS MEM ON MEM.customer_id = S.customer_id AND MEM.join_date < S.order_date
	GROUP BY MEM.customer_id, MEM.join_date, M.product_name
) AS T
WHERE T.ranking = 1;

-- q7: Which item was purchased just before the customer became a member?
-- Antes de convertirse en miembros de Danny's Diner, el cliente B compró Curry, mientras que el cliente A compro tanto Curry como Sushi en una misma orden.
SELECT T.customer_id, T.product
FROM ( 
	SELECT MEM.customer_id,  M.product_name AS product,
		RANK() OVER(PARTITION BY M.product_name ORDER BY MIN(S.order_date) ASC) AS ranking
	FROM sales AS S
		INNER JOIN menu AS M ON M.product_id = S.product_id
		INNER JOIN members AS MEM ON MEM.customer_id = S.customer_id AND MEM.join_date > S.order_date
	GROUP BY MEM.customer_id, MEM.join_date, M.product_name
) AS T
WHERE T.ranking = 1;

-- q8: What is the total items and amount spent for each member before they became a member?
-- Antes de convertirse en miembros del restaurante, B compró 3 platillos y gastó en total de $40 USD, y A compró 2 platillos gastando un total de $25 USD
SELECT MEM.customer_id,  COUNT(S.product_id) AS total_items, SUM(M.price) AS total_amount
FROM sales AS S
	INNER JOIN menu AS M ON M.product_id = S.product_id
	INNER JOIN members AS MEM ON MEM.customer_id = S.customer_id AND MEM.join_date > S.order_date
GROUP BY MEM.customer_id;

-- q9: If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- Total de puntos por cliente registrado: B es el que mayor cantidad de punto a acumulado con 940, y A solo 860.
SELECT S.customer_id, SUM(points) AS total_points 
FROM sales AS S
    INNER JOIN members AS MEM ON MEM.customer_id = S.customer_id    
	INNER JOIN (
		SELECT product_id, CASE WHEN product_name = 'sushi' THEN price * 20 ELSE price * 10 END AS points
        FROM menu 
    ) AS T ON T.product_id = S.product_id
GROUP BY S.customer_id;


-- q10: In the first week after a customer joins the program (including their join date) they earn 2x points on all items, 
-- 		not just sushi - how many points do customer A and B have at the end of January?
-- Durante la primer semana despues de registrarse como cliente en Danyn's Diner el cliente A realizó más compras por lo cuál logró acumular
-- un total de 1,370 puntos, en cambio B solo consiguió 940.
SELECT MEM.customer_id, 
	SUM(
		CASE WHEN (S.order_date BETWEEN MEM.join_date AND MEM.join_date+7) OR (M.product_name = 'sushi') THEN price * 20
			ELSE M.price * 10 END
    ) AS points
FROM sales AS S
    INNER JOIN members AS MEM ON MEM.customer_id = S.customer_id AND MEM.join_date
	INNER JOIN menu AS M ON M.product_id = S.product_id
WHERE S.order_date <=  '2021-01-31'
GROUP BY MEM.customer_id
ORDER BY S.customer_id;





