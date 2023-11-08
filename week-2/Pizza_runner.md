# Danny's Diner

Base de datos: `pizza_runner` <br>
Tablas: 
- `runners`: Catálogo de repartidores.
- `customer_orders` Ordenes de los clientes.
- `runner_orders` Ordenes asignadas a los repartidores.
- `pizza_names`: Catálogo de pizzas.
- `pizza_recipes`: Recetas de las pizzas.
- `pizza_toppings`: Catálogo de toppings que pueden incluirse en las recetas de cada pizza.

[Script para crear y llenar las tablas](./CREATED_DB_TABLES.sql)

## Diagrama Entidad Relación

![Diagrama Entidad Relación - Week 2](../imgs/week-2_Diagram.png)

## Preguntas
Este caso de estudio divide las preguntas por categoría.
- Pizza Metrics
- Runner and Customer Experience
- Ingredient Optimisation
- Pricing and Ratings
- Bonus DML Challenges (DML = Data Manipulation Language)

### Pizza Metrics 📊
El código SQL que responde a todas las preguntas de esta categoría estan en el archivo [pizza_runner_questions_metrics.sql](./pizza_runner_questions_metrics.sql)

1. How many pizzas were ordered?
2. How many unique customer orders were made?
3. How many successful orders were delivered by each runner?
4. How many of each type of pizza was delivered?
5. How many Vegetarian and Meatlovers were ordered by each customer?
6. What was the maximum number of pizzas delivered in a single order?
7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
8. How many pizzas were delivered that had both exclusions and extras?
9. What was the total volume of pizzas ordered for each hour of the day?
10. What was the volume of orders for each day of the week?