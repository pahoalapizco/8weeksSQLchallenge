# Danny's Diner

Base de datos: `dannys_diner` <br>
Tablas: 
- `sales`: Registro de ventas, columnas: `customer_id`, `order_date` y `product_id`. 
- `menu`: Lista de platillos/productos, columnas: `product_id`, `product_name` y `price`.
- `members`: Registro de clientes, columnas: `customer_id` y `join_date`.

## Diagrama Entidad Relación

![Diagrama Entidad Relación](../imgs/week-1_Diagram.png)

## Preguntas
El código SQL que responde a todas las preguntas de este caso de estudio estan en ell archivo [dannys_diner_questions.sql](./dannys_diner_questions.sql)

📢 Las preguntas del caso de estudio son copia y pega del recurso original, por lo tanto estaran en inglés.

1. What is the total amount each customer spent at the restaurant? <br>
**Resultado**: El cliente A es el mayor consumidor con un total gastado de $76 USD.

![Q1](./imgs/q1_response.png)

2. How many days has each customer visited the restaurant? <br>
**Resultado**: Con 6 dias en total, el cliente B es quien tiene mayor cantidad de visitas. Mientras que el cliente A tiene 4 y el cliente C tiene 2 visitas registradas.

![Q2](./imgs/q2_response.png)

3. What was the first item from the menu purchased by each customer? <br>
**Resultado**: En el caso del cliente A su primier compra fue de 2 platillos distintos, sushi y curry.


![Q3](./imgs/q3_response.png)

4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?