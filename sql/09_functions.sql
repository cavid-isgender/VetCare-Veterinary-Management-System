-- Query 1: Create a function that calculates the total amount of a specific order.
create or REPLACE function calculate_order_total(id_order order_items.order_id%type)
returns decimal as $$
DECLARE
	total DECIMAL := 0;
begin
	select coalesce(sum(quantity*unit_price),0) as total_amount into total 
	from order_items where order_id = id_order;
	raise notice 'Total amount of the order: %',total;
	return total;
end;
$$ LANGUAGE 'plpgsql';

SELECT calculate_order_total(8);


-- Query 2: Create a function that checks whether enough stock is available for a product.
create or replace FUNCTION check_product_stock(pro_id products.product_id%type, requested_quantity INTEGER)
returns boolean as $$
DECLARE
	available_stock INTEGER; 
BEGIN
	select stock_quantity into available_stock from products where product_id = pro_id;

	if not found then
		raise exception 'Product with ID % does not exist.',pro_id;
	end if;

	if requested_quantity <= 0 then
		raise exception 'Requested quantity must be greater than 0.';
	end if;
	
	if available_stock >= requested_quantity THEN
		raise notice 'Enough quantity!';
		return True;
	else
		raise notice 'Not enough stock!';
		RETURN False;
	end if;
end;
$$ LANGUAGE 'plpgsql';

SELECT check_product_stock(7, 10);


-- Query 3: Create a function that calculates the total spending of a specific customer.
create or REPLACE FUNCTION calculate_customer_spending(customer_id orders.user_id%type)
returns numeric as $$
DECLARE
	all_amount NUMERIC;
begin
	select coalesce(sum(total_amount),0) into all_amount from orders where user_id = customer_id;
	return all_amount;
end;
$$ LANGUAGE 'plpgsql';

select calculate_customer_spending(4);


-- Query 4: Create a function that checks whether a pet has an overdue vaccination.
create or REPLACE function is_vaccination_overdue(p_id vaccinations.pet_id%type)
returns boolean as $$
begin
	if exists(
		select 1 from vaccinations where pet_id = p_id and next_due_date < CURRENT_DATE
	) THEN
		return TRUE;
	else
		return FALSE;
	end if;
end;
$$ LANGUAGE 'plpgsql';

select is_vaccination_overdue(7);


-- Query 5: Create a function that returns the number of upcoming appointments for a specific veterinarian.
create or replace function get_upcoming_appointments(id_vet vet_appointments.veterinarian_id%type)
returns bigint as $$
declare
	number_of_appointments BIGINT;
begin
	select count(appointment_id) into number_of_appointments from vet_appointments
	where veterinarian_id = id_vet 
	and (appointment_date > CURRENT_DATE 
	or (appointment_date = CURRENT_DATE and appointment_time > CURRENT_TIME));
	return number_of_appointments;
end;
$$ LANGUAGE 'plpgsql';

select get_upcoming_appointments(5);

drop FUNCTION get_upcoming_appointments(vet_appointments.veterinarian_id%type);
