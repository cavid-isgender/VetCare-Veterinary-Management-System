-- Query 1: Show all users
select * FROM users;

-- Query 2: Show users from Lodz
SELECT * FROM users WHERE address = 'Lodz';

-- Query 3: Show products that cost more than 50
select name, price from products WHERE price > 50;

-- Query 4: Show products ordered by price from highest to lowest
SELECT name, price FROM products order by price DESC;

-- Query 5: Show users from Lodz who have a phone number
select * from users where address = 'Lodz' and phone is not NULL;

-- Query 6: Show pets that are dogs and weigh more than 20 kg
select * from pets where species = 'Dog' and weight_kg >= 20;

-- Query 7: Show pets that are cats or dogs
select name,species,breed from pets where species = 'Cat' or species = 'Dog';

-- Query 8: Show products that belong to the Food or Health categories
select * from products;
select * from products where category = 'Food' or category = 'Health';
--or we can write:
select * from products where category in ('Food','Health');

-- Query 9: Show users who live in Lodz, Warsaw, or Krakow
select * from users where address in('Lodz','Warsaw','Krakow');

-- Query 10: Show products with prices between 30 and 70
select * from products where price between 30 and 70;

-- Query 11: Show pets born between 2020-01-01 and 2022-12-31
select * from pets where birth_date between '2020-01-01' and '2022-12-31';

-- Query 12: Show users whose first name starts with the letter 'A'
select first_name,last_name,email from users where first_name like 'A%';

-- Query 13: Show products whose name contains the word 'Cat'
select * from products where name like '%Cat%';

-- Query 14: Show pets that do not have a breed specified
select * from pets where breed is NUll;

-- Query 15: Show products that are active and have more than 30 items in stock
select * from products where is_active = TRUE and stock_quantity > 30;

-- Query 16: Show all different cities where users live
select distinct address,first_name, last_name from users;

-- Query 17: Show all different pet species
select distinct species,name,breed from pets;

-- Query 18: Show the 5 most expensive products
select * from products order by price desc limit 5;

-- Query 19: Show the 3 cheapest products
select * from products order by price asc limit 3;

-- Query 20: Skip the first 3 products and show the next 5 products
select * from products order by product_id limit 5 offset 3;

-- Query 21: Show user names with custom column names
select first_name as "First Name", last_name as "Last Name", email as "Email Address" from users;

-- Query 22: Show product names and calculate the price including 23% tax
select name,price, (price*123/100)::numeric(5,2) as "23% tax" from products;
--alternative version:
select name,price, ROUND((price*123/100),2) as "23% tax" from products; 

-- Query 23: Show whether each product is cheap, moderate, or expensive
select name,category,brand,price,
	case
		when price < 30 then 'Cheap'
		when price between 30 and 60 then 'Moderate'
		else 'Expensive'
	end as price_category
from products;

-- Query 24: Count the total number of users
select count(*) as total_users from users;

-- Query 26: Find the average product price
select avg(price) as average_price from products;

-- Query 27: Find the highest and lowest product prices
select max(price) as highest_price, min(price) as lowest_price from products;

-- Query 28: Calculate the total value of all products in stock
select sum(price*stock_quantity) as total_inventory_value from products;

-- Query 29: Count the number of veterinarians
select count(*) as total_veterinarians from veterinarians;

-- Query 30: Find the average weight of all pets
select avg(weight_kg) as average_weight from pets;

-- Query 31: Count the number of pets owned by each user
select owner_id,count(*) as number_of_pets from pets group by owner_id order by owner_id;

-- Query 32: Count the number of veterinarians in each clinic
select clinic_id,count(*) as number_veterinarians from veterinarians group by clinic_id order by clinic_id;

-- Query 33: Find the average pet weight for each species
select species, avg(weight_kg) as average_weight from pets group by species;

-- Query 34: Find the minimum and maximum pet weight for each species
select species,min(weight_kg) as min_weight, max(weight_kg) as max_weight from pets group by species;

-- Query 35: Calculate the total stock quantity for each product category
select category,sum(stock_quantity) as total_stock from products group by category;

-- Query 36: Calculate the average price for each product category
select category, avg(price)::decimal(5,2) as ave_price from products group by category;

-- Query 37: Count orders for each order status
select status, count(*) as count_orders from orders group by status;

-- Query 38: Calculate the total order amount for each order status
select status, sum(total_amount) as sum_amount from orders group by status;

-- Query 39: Show users who own more than one pet
select owner_id,count(pet_id) as pet_count from pets group by owner_id having count(pet_id) > 1 order by owner_id;

-- Query 40: Show product categories with more than 2 products
select category, count(*) as product_count from products group by category having count(*)>2;

-- Query 41: Show product categories with an average price greater than 50
select category, avg(price)::decimal(5,2) as ave_price from products group by category having avg(price)>50;

-- Query 42: Show clinics that have at least 2 veterinarians
select clinic_id, count(*) as veterinarian_count from veterinarians group by clinic_id having count(*) >=2 order by clinic_id;

-- Query 43: Count the number of appointments for each veterinarian
select veterinarian_id, count(appointment_id) as count_appointment from vet_appointments group by veterinarian_id order by veterinarian_id;

-- Query 44: Show veterinarians who have more than one appointment
select veterinarian_id, count(*) as appointment_count from vet_appointments group by veterinarian_id having count(*)>1 order by veterinarian_id;

-- Query 45: Calculate the total quantity of products sold in order items
select sum(quantity) as total_quantity_sold from order_items;