
-- Query 1: Update product stock and roll back the change

BEGIN;

UPDATE products 
SET stock_quantity = stock_quantity + 5
WHERE product_id = 1;

SELECT product_id, name, stock_quantity
FROM products
WHERE product_id = 1;

ROLLBACK;

SELECT product_id, name, stock_quantity
FROM products
WHERE product_id = 1;



-- Query 2: Use a savepoint to roll back only part of a transaction

BEGIN;

UPDATE products
SET stock_quantity = stock_quantity + 10
WHERE product_id = 1;

SAVEPOINT stock_checkpoint;

UPDATE products
SET stock_quantity = stock_quantity + 20
WHERE product_id = 1;

SELECT product_id, name, stock_quantity from products WHERE product_id = 1;

ROLLBACK TO SAVEPOINT stock_checkpoint;

select product_id, name, stock_quantity FROM products WHERE product_id = 1;
ROLLBACK;
COMMIT;

-- Query 3: Create an order and insert its items in one transaction

begin;
with new_order as(
	INSERT into orders(user_id,status,total_amount)
	VALUES(1,'Pending',85)
	RETURNING order_id
)
INSERT into order_items(order_id,product_id,quantity,unit_price)
SELECT order_id,1,2,20.00 from new_order
UNION all
select order_id,2,3,15.00 from new_order;
select * from order_items;

SELECT o.order_id,
       o.user_id,
       o.total_amount,
       oi.product_id,
       oi.quantity,
       oi.unit_price
FROM orders o
INNER JOIN order_items oi
    ON oi.order_id = o.order_id
WHERE o.user_id = 1
ORDER BY o.order_id DESC, oi.product_id;

commit;


-- Query 4: Create an order only if sufficient stock is available

begin;

do $$
DECLARE
	new_order_id int;
	stock_1 int;
	stock_2 int;
BEGIN
	select stock_quantity into stock_1 from products where product_id = 1 for update;
	select stock_quantity into stock_2 from products where product_id = 2 for update;

	if stock_1 is NULL or stock_2 is NULL THEN
		raise EXCEPTion 'One or more products do not exist!';
	end if;

	if stock_1<2 or stock_2<3 THEN
		raise exception 'Insufficient stock for this order';
	end if;

	INSERT into orders(user_id,status,total_amount) VALUES(1,'Pending',85)
	returning order_id into new_order_id;

	insert into order_items(order_id,product_id,quantity,unit_price)
	VALUES
	(new_order_id,1,2,20.00),
	(new_order_id,2,3,15.00);

END $$;

COMMIT;

-- Query 5: Recover from a failed operation using a savepoint

-- Make a valid stock update, increase the amount of stock 5 items
-- Create a savepoint before the risky operation
-- Intentionally attempt an invalid update
-- If the previous statement fails because of a constraint, recover to the savepoinT
-- Check the stock
-- Save the valid change

BEGIN;

UPDATE products
set stock_quantity = stock_quantity + 5
where product_id = 1;

SAVEPOINT before_risky_update;

update products
set stock_quantity = -1
WHERE product_id = 1;

ROLLBACK to SAVEPOINT before_risky_update;

select product_id, name, stock_quantity from products where product_id = 1;

COMMIT;