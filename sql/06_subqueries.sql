-- Query 1: Show products whose price is higher than the average product price.
-- Display the product name and price.
select name, price from products where price > (select avg(price) from products);

-- Query 2: Show pets that belong to users who live in Lodz.
-- Display the pet name and owner's full name.
select p.name as pet_name,
(select u.first_name || ' ' || u.last_name from users u where u.user_id = p.owner_id) as full_name_owner
from pets p 
where p.owner_id in (select u.user_id from users u where u.address = 'Lodz' );

-- Query 3: Show products that have never been ordered.
-- Display the product name and price.
select p.name as Product_name, p.price as product_price FROM products p
where p.product_id not in (select oi.product_id from order_items oi);

-- Query 4: Show users who have placed at least one order.
-- Display the user's full name and email.
select u.first_name || ' ' || u.last_name as full_name, u.email from users u
where exists(select o.order_id from orders o where o.user_id = u.user_id);

-- Query 5: Show veterinarians who have never handled an appointment.
-- Display the veterinarian's full name and specialization.
select v.first_name || ' ' || v.last_name as full_name, v.specialization from veterinarians v
where not exists(select va.appointment_id from vet_appointments va where va.veterinarian_id = v.veterinarian_id);

-- Query 6: Show the most expensive product.
-- Display the product name and price.
select p.name as product_name, p.price as product_price from products p
where p.price = (select max(price) from products);

-- Query 7: Show products whose price is higher than the average price of their own category.
-- Display the product name, category, and price.
select p.name as product_name, p.category, p.price as product_price from products p
where p.price >= (select avg(p2.price) from products p2 where p.category = p2.category);

-- Query 8: Show users whose total spending is greater than the average total spending of all users.
-- Display the user's full name and total spending.
select u.first_name || ' ' || u.last_name as full_name,
(select sum(o.total_amount) from orders o where o.user_id = u.user_id) as total_spending from users u
WHERE 
(select sum(o.total_amount) from orders o where o.user_id = u.user_id) >= 
(select avg(o2.total_amount) from orders o2);


-- Query 9: Show pets that have at least one vaccination.
-- Display the pet name and species.
select p.name as pet_name, p.species from pets p 
where exists (select v.vaccination_id from vaccinations v where v.pet_id = p.pet_id);


-- Query 10: Show each clinic whose number of veterinarians is greater than the average number of veterinarians per clinic.
-- Display the clinic name and veterinarian count.
select c.name as clinic_name, (select count(v.veterinarian_id) as veter_count from veterinarians v where c.clinic_id = v.clinic_id)
from clinics c where 
(select count(v.veterinarian_id) as veter_count from veterinarians v where c.clinic_id = v.clinic_id)
>
(select avg(veterinarian_count) 
from (select clinic_id, count(veterinarian_id) as veterinarian_count from veterinarians group by clinic_id) as clinic_counts);

