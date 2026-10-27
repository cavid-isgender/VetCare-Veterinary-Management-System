-- Query 1: Create a trigger that automatically decreases product stock
-- when a new order item is inserted.

CREATE or replace FUNCTION update_product_store()
RETURNS trigger as $$
BEGIN
	update products
	set stock_quantity = stock_quantity - new.quantity
	where product_id = new.product_id;
	return new;
end;
$$ LANGUAGE 'plpgsql';


CREATE or replace trigger trig_product_stock
after insert on order_items
for each row execute procedure update_product_store();


insert into order_items(order_id,product_id,quantity,unit_price)
VALUES (7,10,8,74.99);

select * from products;
select * from orders;
select * from order_items;


-- Query 2: Create a trigger that prevents a product's stock from becoming negative.

create or REPLACE FUNCTION prevent_negative_stock()
returns trigger as $$
declare
	current_stock int;
begin
	select stock_quantity into current_stock from products where product_id = new.product_id;
	IF NEW.quantity <= 0 THEN
    RAISE EXCEPTION 'Quantity must be greater than zero!';
    END IF;
	if current_stock < new.quantity then 
		raise exception 'Insufficient Stock!';
	end if;
	return new;
end;
$$ LANGUAGE 'plpgsql';


create or replace trigger trig_negative_stock
before insert on order_items
for each row execute function prevent_negative_stock();

insert into order_items(product_id,quantity)
VALUES(3,12);
insert into order_items(product_id,quantity)
VALUES(8,33);

select * from products;


-- Query 3: Create a trigger that automatically updates the order total when an order item is inserted.

create or replace FUNCTION update_order_total()
returns trigger as $$
begin
	update orders
	set total_amount = (
		select sum(quantity*unit_price) from order_items where order_id = new.order_id
	)
	where order_id = new.order_id;
	return new;
end;
$$ LANGUAGE 'plpgsql';

-- DROP TRIGGER IF EXISTS trig_order_total ON order_items;

create or REPLACE TRIGGER trig_order_total
after insert on order_items
for each row execute function update_order_total();

insert into order_items(order_id,product_id,quantity,unit_price)
VALUES(4,6,3,59.99);

select * from products;
select * from orders;
select * from order_items;


-- Query 4: Create a trigger that prevents an appointment
-- from being created with a date in the past.

create or replace FUNCTION invalid_appointment_dates()
returns trigger as $$
begin
	if new.appointment_date < CURRENT_DATE then
		raise exception 'Date cannot be in the past!';
	end if;
	return new;
end;
$$ LANGUAGE 'plpgsql';

CREATE or REPLACE trigger trig_prevent_invalid_appdate
before INSERT or UPDATE on vet_appointments
for each row execute function invalid_appointment_dates();

select * from vet_appointments;

insert into vet_appointments(pet_id,veterinarian_id,appointment_date,appointment_time,reason,status,notes)
VALUES(11,5,'2026-10-11','12:00','General check-up','Completed','General health examination');
