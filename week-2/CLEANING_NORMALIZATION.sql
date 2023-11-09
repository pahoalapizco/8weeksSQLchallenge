USE pizza_runner;

-- Las columnas "exlusions" y "extras" que tengan un valor vacío o tengan la palabra "null" seran reemplazados por un valor null (no en texto)
SELECT * FROM customer_orders;

-- Las columnas con valores vacíos y "null" pasaran a nulo/NULL (null, no string) 
SELECT * FROM runner_orders;

START TRANSACTION;

-- TABLA: customer_orders
-- Exclusions
UPDATE customer_orders SET exclusions = NULL WHERE exclusions IN ('', 'null');
-- Extras
UPDATE customer_orders SET extras = NULL WHERE extras IN ('', 'null');

SELECT * FROM customer_orders;

-- TABLA: runner_orders
-- Estandarización: Cambio de vacio y "null" a un valor NULL (no string), eliminan caracteres y espacios en blanco de 
-- las columnas distance y duration para dar paso solo a valores numéricos.

-- pickup_time
UPDATE runner_orders SET pickup_time = NULL WHERE pickup_time IN ('', 'null');

-- distance
UPDATE runner_orders SET distance = NULL WHERE distance IN ('', 'null');
UPDATE runner_orders SET distance = TRIM(REGEXP_REPLACE(distance, '[a-z]', '')) WHERE distance IS NOT NULL;

-- duration
UPDATE runner_orders SET duration = NULL WHERE duration IN ('', 'null');
UPDATE runner_orders SET duration = TRIM(REGEXP_REPLACE(duration, '[a-z]', '')) WHERE duration IS NOT NULL;

-- Cancellation
UPDATE runner_orders SET cancelation = NULL WHERE cancelation IN ('', 'null');

-- Corrección del tipo de dato de las columnas pickup_time, distance y duration
-- Cambio en el tipo de dato de la columna pickup_time, de VARCHAR A DATETIME
ALTER TABLE runner_orders MODIFY pickup_time DATETIME;
-- Cambio en el tipo de dato de la columna distance, de VARCHAR A FLOAT
ALTER TABLE runner_orders MODIFY distance FLOAT;
-- Cambio en el tipo de dato de la columna duration, de VARCHAR A INTEGER
ALTER TABLE runner_orders MODIFY duration INTEGER;

-- ROLLBACK;
-- COMMIT;

SELECT * FROM runner_orders;

-- Revisión de los tipos de dato.
/*
SELECT DATA_TYPE,CHARACTER_MAXIMUM_LENGTH
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA='pizza_runner'
  AND TABLE_NAME='customer_orders'
  AND COLUMN_NAME='order_time';
*/

