DROP FUNCTION IF EXISTS public.get_customer_orders(INTEGER);

CREATE or REPLACE FUNCTION get_customer_orders(customer_id integer)
RETURNS table(
order_id integer,
total_amount numeric
) as $$
DECLARE
	cur CURSOR FOR
		select o.order_id, o.total_amount from orders o where o.user_id = customer_id;
	setir record;
begin
	for setir in cur Loop
		order_id := setir.order_id;
		total_amount := setir.total_amount;
		return next;
	end loop;	
end;
$$ LANGUAGE 'plpgsql';

select user_id from users order by  user_id;

select get_customer_orders(5);


CREATE or REPLACE FUNCTION count_vet_appointments(vet_id integer)
RETURNs integer as $$
DECLARE
	cursor1 CURSOR FOR
		select appointment_id,appointment_date,appointment_time,status from vet_appointments
		where veterinarian_id = vet_id;
	setir record;
	toplam INTEGER := 0;
begin
	for setir in cursor1 loop
		raise notice 'Appointment ID: %, Date: %, Time: %, Status: %',
		setir.appointment_id, setir.appointment_date, setir.appointment_time, setir.status;
		toplam := toplam + 1;
	end loop;
	return toplam;
end;
$$ LANGUAGE 'plpgsql';

select count_vet_appointments(5);

