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

4. What is the most purchased item on the menu and how many times was it purchased by all customers? <br>
**Resultado**: Ramen es el producto más vendido del menú con un total de 8 ventas en total.

![Q4](./imgs/q4_response.png)

5. Which item was the most popular for each customer? <br>
**Resultado**: Para los clientes A y C el producto/platillo más popular es el ramen, sin embargo B a comprado por igual los 3 distintos platillos del menu.

![Q5](./imgs/q5_response.png)

6. Which item was purchased first by the customer after they became a member? <br>
**Resultado**: El primer platillo que compró el cliente A fue Ramen y B compró Sushi.

![Q6](./imgs/q6_response.png)

7. Which item was purchased just before the customer became a member? <br>
**Resultado**: Antes de convertirse en miembros de Danny's Diner, el cliente B compró Curry, mientras que el cliente A compro tanto Curry como Sushi en una misma orden.

![Q7](./imgs/q7_response.png)

8. What is the total items and amount spent for each member before they became a member? <br>
**Resultado**: Antes de convertirse en miembros del restaurante, B compró 3 platillos y gastó en total de $40 USD, y A compró 2 platillos gastando un total de $25 USD

![Q8](./imgs/q8_response.png)

9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have? <br>
**Resultado**: Total de puntos por cliente registrado: B es el que mayor cantidad de punto a acumulado con 940, y A solo 860.

![Q9](./imgs/q9_response.png)


10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January? <br>
**Resultado**: Durante la primer semana despues de registrarse como cliente en Danyn's Diner el cliente A realizó más compras por lo cuál logró acumular un total de 1,370 puntos, en cambio B solo consiguió 940.

![Q10](./imgs/q10_response.png)