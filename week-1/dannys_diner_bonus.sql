USE dannys_diner;

-- Bonus #1, Relación de clientes y sus comprar realizadas, con un marcador de si era o no miembro del restaurante al momento de realizar la compra,
--  "Y" = El cliente registrado al momento de la compra
-- "N" = El cliente no registrado al momento de la compra.
CREATE VIEW vsales
AS
	SELECT S.customer_id, S.order_date, M.product_name, M.price,
		CASE WHEN MEM.customer_id IS NULL OR MEM.join_date > S.order_date
		THEN "N" 
		ELSE "Y" 
	END AS member
	FROM sales AS S
		INNER JOIN menu AS M ON M.product_id = S.product_id
		LEFT JOIN members AS MEM ON MEM.customer_id = S.customer_id;
        
SELECT * FROM vsales;

-- Bonus #2: Ranking de los productos preferedidos de los clientes registrados como miembros del restaurante.
CREATE OR REPLACE VIEW vRanking (customer_id, order_date, product_name, price, member, ranking)  AS
SELECT S.customer_id, S.order_date, M.product_name, M.price,
	CASE WHEN ISNULL(MEM.customer_id) OR MEM.join_date > S.order_date THEN "N" ELSE "Y" END AS member,
    CASE WHEN ISNULL(MEM.customer_id) OR MEM.join_date > S.order_date THEN NULL 
		ELSE 
			RANK() OVER(PARTITION BY S.customer_id, (CASE WHEN (S.order_date < MEM.join_date) OR ISNULL(MEM.customer_id) THEN NULL ELSE 1 END)
					ORDER BY S.customer_id, S.order_date ASC
				)
        END AS ranking
FROM sales AS S
	INNER JOIN menu AS M ON M.product_id = S.product_id
    LEFT JOIN members AS MEM ON MEM.customer_id = S.customer_id;

SELECT * FROM vRanking;