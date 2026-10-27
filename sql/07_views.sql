-- Query 1: Create a view that shows each customer's total spending.
-- Display the customer ID, full name, and total spending.
create or REPLACE view customer_spending as
select o.user_id as customer_id, u.first_name||' '||u.last_name as full_name, sum(o.total_amount) as total_spending
from orders o inner join users u on u.user_id = o.user_id GROUP BY o.user_id, u.first_name, u.last_name order by o.user_id;

select * from customer_spending;

-- Query 2: Create a view that shows each pet together with the number of health records.
-- Display the pet ID, pet name, and health record count.
CREATE or REPLACE view pet_health_count AS
select p.pet_id,p.name as pet_name, count(phr.record_id) as health_record_count
from pets p left join pet_health_records phr ON phr.pet_id = p.pet_id
group by p.pet_id,p.name ORDER by p.pet_id;
SELECT * from pet_health_count;

-- Query 3: Create a view that shows each veterinarian together with the number of completed appointments.
-- Display the veterinarian ID, full name, and completed appointment count.
create or REPLACE view completed_veter_appointments as 
select v.veterinarian_id,v.first_name||' '||v.last_name as full_name, count(va.appointment_id) as count_appointments
from veterinarians v inner join vet_appointments va ON va.veterinarian_id = v.veterinarian_id and va.status = 'Completed'
group by v.veterinarian_id, v.first_name||' '||v.last_name order by v.veterinarian_id;
SELECT * from completed_veter_appointments;

-- Query 4: Create a view that shows each product together with its total quantity sold and total revenue.
-- Display the product name, total quantity sold, and total revenue.
CREATE or REPLACE VIEW product_quantity_revenue AS
select p.name, sum(oi.quantity) as total_quantity_sold, sum(oi.quantity*oi.unit_price) as total_revenue
from products p left join order_items oi ON oi.product_id = p.product_id group by p.name;
SELECT * from product_quantity_revenue;

-- Query 5: Create a view that shows upcoming veterinary appointments.
-- Display the appointment date, appointment time, pet name, veterinarian full name, and clinic name.
create or REPLACE view upcoming_vet_app AS
select va.appointment_date, va.appointment_time, p.name, v.first_name||' '||v.last_name as full_name, c.name as clinic_name
from vet_appointments va inner join veterinarians v on v.veterinarian_id = va.veterinarian_id 
inner join pets p ON p.pet_id = va.pet_id inner join clinics c on c.clinic_id = v.clinic_id
where va.appointment_date > CURRENT_DATE OR (va.appointment_date = CURRENT_DATE AND va.appointment_time > CURRENT_TIME);
SELECT * from upcoming_vet_app;

