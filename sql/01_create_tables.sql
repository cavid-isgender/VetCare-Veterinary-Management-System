CREATE TABLE users(
user_id serial,
first_name varchar(50),
last_name varchar(50),
email varchar(100) UNIQUE not null,
password_hash varchar(255),
phone varchar(20),
address varchar(255),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
constraint pk_users primary key (user_id)
);

CREATE TABLE pets(
pet_id SERIAL,
owner_id INT not null,
name varchar(50) not null,
species varchar(50) not NULL,
breed varchar(50),
gender varchar(50),
birth_date date,
weight_kg decimal(5,2),
color varchar(30),
microchip_number varchar(50) UNIQUE not null,
CONSTRAINT pk_pets PRIMARY KEY (pet_id),
CONSTRAINT fk_pets FOREIGN KEY (owner_id) REFERENCES users (user_id) on delete cascade
);

CREATE TABLE clinics(
clinic_id serial PRIMARY Key,
name varchar(100) not null,
address varchar(255),
city varchar(50),
phone varchar(20),
email varchar(100),
opening_time TIME,
closing_time TIME
);

CREATE TABLE veterinarians(
veterinarian_id serial Primary Key,
clinic_id int not null,
first_name varchar(50),
last_name varchar(50),
specialization varchar(100),
phone varchar(20),
email varchar(100),
years_of_experience int,
license_number varchar(50) UNIQUE,
constraint fk_veterinarians foreign key (clinic_id) references clinics (clinic_id) on delete cascade
);

create TABLE vet_appointments(
appointment_id serial Primary Key,
pet_id int REFERENCES pets(pet_id) on delete cascade,
veterinarian_id int REFERENCES veterinarians(veterinarian_id) on delete cascade,
appointment_date DATE,
appointment_time TIME,
reason VARCHAR(255),
status varchar(20) CHECK(status in ('Pending','Confirmed','Completed','Cancelled')),
notes text,
created_at timestamp DEFAULT current_timestamp
);

create TABLE vaccinations(
vaccination_id serial,
pet_id int,
vaccine_name varchar(100),
vaccination_date DATE,
next_due_date DATE,
veterinarian_id INT,
notes text,
constraint pk_vaccinations PRIMARY Key (vaccination_id),
constraint fk_vaccinations_pet FOREIGN Key(pet_id) REFERENCES pets(pet_id) on delete cascade,
constraint fk_vaccinations_veterinarian FOREIGN Key(veterinarian_id) references veterinarians(veterinarian_id) on delete cascade
);

create TABLE pet_health_records(
record_id serial primary key,
pet_id int,
veterinarian_id int,
record_date Date,
diagnosis varchar(255),
symptoms text,
treatment text,
notes text,
constraint fk_health_records_pet foreign key (pet_id) REFERENCES pets(pet_id) on delete cascade,
CONSTRAINT fk_health_records_veterinarian foreign key (veterinarian_id) references veterinarians(veterinarian_id) on delete cascade
);

CREATE TABLE products(
product_id serial primary key,
name varchar(100),
category varchar(50),
description text,
price decimal(10,2) CHECK (price>=0),
stock_quantity int check(stock_quantity >=0 ),
brand varchar(50),
is_active boolean,
created_at timestamp default current_timestamp
);

CREATE TABLE orders(
order_id serial,
user_id int,
order_date timestamp default current_timestamp,
status varchar(20),
shipping_address varchar(255),
total_amount decimal(10,2)
);

CREATE TABLE order_items(
order_item_id serial primary key,
order_id int references orders(order_id) on delete cascade,
product_id int,
quantity int,
unit_price decimal(10,2),
foreign key (product_id) REFERENCES products(product_id) on delete cascade
);

alter TABLE orders add constraint pk_orders PRIMARY key(order_id);
alter table orders add constraint orders_fk FOREIGN Key(user_id) REFERENCES users(user_id) on delete cascade;





