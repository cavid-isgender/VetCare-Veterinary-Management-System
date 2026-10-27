-- Query 1: Show each pet together with its owner's first and last name
select name,first_name,last_name from users INNER Join pets on owner_id = user_id;

-- Query 2: Show each veterinarian together with the name of their clinic
select first_name,last_name,name from veterinarians v,clinics c where v.clinic_id = c.clinic_id;

-- Query 3: Show each vaccination together with the pet's name
select vaccine_name,name from vaccinations v left join pets p on p.pet_id = v.pet_id;

-- Query 4: Show each appointment together with the pet's name and veterinarian's name
select va.appointment_date,p.name as pet_name,ve.first_name AS veterinarian_name
FROM vet_appointments va INNER JOIN pets p ON va.pet_id = p.pet_id INNER JOIN veterinarians ve ON va.veterinarian_id = ve.veterinarian_id;

-- Query 5: Show each order together with the customer's first and last name
select o.status, o.total_amount, u.first_name, u.last_name from orders o inner join users u on u.user_id = o.user_id;

-- Query 6: Show each order item together with the product name and quantity
select p.name AS product_name, o.quantity from order_items o INNER JOIN products p ON o.product_id = p.product_id;
	
-- Query 7: Show each pet together with its owner's email address
select p.name as pet_name, u.email from pets p left join users u on u.user_id = p.owner_id;

-- Query 8: Show each health record together with the pet's name and veterinarian's name
select diagnosis, name as pet_name, first_name as veterinarian_name from pet_health_records pr, pets p,veterinarians v
where pr.veterinarian_id = v.veterinarian_id and pr.pet_id = p.pet_id; 

-- Query 9: Show pets together with their owners who live in Lodz
SELECT p.name AS pet_name, u.first_name, u.last_name
from pets p INNER JOIN users u ON p.owner_id = u.user_id where u.address = 'Lodz';


-- Query 10: Show veterinarians who work at clinics located in Lodz
select v.first_name,v.last_name,c.name as clinic_name FROM veterinarians v INNER JOIN clinics c
ON v.clinic_id = c.clinic_id WHERE c.city like 'Lodz%';


-- Query 11: Show completed appointments together with the pet name and veterinarian name
select va.appointment_date,va.appointment_time,p.name AS pet_name,v.first_name AS veterinarian_name
FROM vet_appointments va INNER join pets p ON va.pet_id = p.pet_id
INNER JOIN veterinarians v ON va.veterinarian_id = v.veterinarian_id
where va.status = 'Completed';


-- Query 12: Show all pets and their vaccination information
select p.name AS pet_name,v.vaccine_name,v.vaccination_date,v.next_due_date
from pets p LEFT JOIN vaccinations v ON p.pet_id = v.pet_id;


-- Query 13: Show each vaccination together with the pet name and veterinarian name
SELECT v.vaccine_name, v.vaccination_date,p.name AS pet_name, CONCAT(vet.first_name,'  ',vet.last_name) AS veterinarian_fullname
FROM vaccinations v INNER JOIN pets p ON v.pet_id = p.pet_id 
INNER JOIN veterinarians vet ON v.veterinarian_id = vet.veterinarian_id;


-- Query 14: Show each order together with the customer's name and order status
select o.order_id,u.first_name,u.last_name,o.status,o.total_amount
FROM orders o inner join users u ON o.user_id = u.user_id;


-- Query 15: Show each order item together with the order ID, product name, quantity, and unit price
select o.order_id,p.name AS product_name, o.quantity, o.unit_price
FROM order_items o inner join products p ON o.product_id = p.product_id;

-- Query 16: Show each product that has been ordered together with the customer who ordered it
select p.product_id, p.name as product_name,oi.quantity,o.status,o.total_amount,u.first_name ||' '|| u.last_name as customer_fullname
from products p inner join order_items oi on p.product_id = oi.product_id
INNER join orders o on o.order_id = oi.order_id
INNER join users u on u.user_id = o.user_id;



-- Query 17: Show all orders together with the customer's full name, total amount, and order date.
-- Sort the results by total amount from highest to lowest.
select o.order_id,o.order_date, o.status,o.total_amount, CONCAT(u.first_name,' ',u.last_name) as customers_fullname
from orders o inner join users u on u.user_id = o.user_id
order by o.total_amount DESC;

-- Query 18: Show each clinic together with the number of veterinarians working at that clinic.
-- Include the clinic name and veterinarian count.
select c.clinic_id,c.name, count(v.veterinarian_id) as number_of_veterinarians 
from clinics c left join veterinarians v on v.clinic_id = c.clinic_id
group by c.clinic_id order by c.clinic_id;

-- Query 19: Show users who have placed more than one order.
-- Display the user's full name and the number of orders.
select u.first_name ||' '|| u.last_name as user_fullname, count(o.order_id) as number_of_orders
from orders o inner join users u on u.user_id = o.user_id
group by u.user_id,u.first_name,u.last_name having count(o.order_id) > 1;

-- Query 20: Show all users who have never placed an order.
-- Display the user's full name and email address.
select u.first_name ||' '||u.last_name as user_name,u.email FROM users u LEFT join orders o on u.user_id = o.user_id
where o.order_id is Null;


-- Query 21: Show each product together with the total quantity ordered and the number of different orders containing that product.
-- Include only products that have been ordered.
select p.name as product_name, sum(oi.quantity) as total_quantity_ordered, count(Distinct oi.order_id) as number_of_orders
from products p inner join order_items oi on oi.product_id = p.product_id
group by p.product_id,p.name;


-- Query 22: Show all upcoming veterinary appointments with the pet name, owner full name, veterinarian full name, clinic name, and appointment date/time.
select va.appointment_date,va.appointment_time, va.appointment_id,p.name as pet_name, u.first_name ||' '||u.last_name as owner_fullname, v.first_name ||' '||v.last_name as veterinarian_fullname,c.name as clinic_name
from vet_appointments va inner join veterinarians v on va.veterinarian_id = v.veterinarian_id
inner join clinics c on c.clinic_id = v.clinic_id inner join pets p on p.pet_id = va.pet_id inner join users u on u.user_id = p.owner_id
where va.status = 'Pending' and va.appointment_date >= Current_date;

-- Query 23: Show each customer's total spending on products.
-- Display the customer's full name and total amount spent.
-- Sort the results from highest spending to lowest.
select u.user_id, u.first_name ||' '|| u.last_name as customer_fullname, sum(oi.quantity*oi.unit_price) as total_amount
from users u inner join orders o on u.user_id = o.user_id inner join order_items oi on oi.order_id = o.order_id
group by u.user_id order by sum(oi.quantity*oi.unit_price) DESC;



-- Query 24: Show each pet's latest health record.
-- Display the pet name, record date, diagnosis, and veterinarian name.
select p.name as pet_name, phr.record_date as record_date, phr.diagnosis, v.first_name||' '||v.last_name as veterinarian_fullname
from pets p inner join pet_health_records phr on phr.pet_id = p.pet_id inner join veterinarians v on v.veterinarian_id = phr.veterinarian_id
where phr.record_date = (select max(phr2.record_date) from pet_health_records phr2 where phr2.pet_id = phr.pet_id);

