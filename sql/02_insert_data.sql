insert into users(first_name,last_name,email,password_hash,phone,address)
VALUES
('Javid','Isgandarli','javid.isgandarli@gmail.com','hash_001','+48501234101','Lodz'),
('Anna','Kowalska','anna.kowalska@gmail.com','hash_002','+48502345212','Warsaw'),
('Michael','Brown','michael.brown@gmail.com','hash_003','+48503456323','Krakow'),
('Sophie','Martin','sophie.martin@gmail.com','hash_004','+48504567434','Wroclaw'),
('Daniel','Wilson','daniel.wilson@gmail.com','hash_005','+48505678545','Poznan'),
('Emma','Johnson','emma.johnson@gmail.com','hash_006','+48506789656','Gdansk'),
('Lucas','Miller','lucas.miller@gmail.com','hash_007','+48507890767','Lodz'),
('Olivia','Taylor','olivia.taylor@gmail.com','hash_008','+48508901878','Katowice'),
('Adam','Nowak','adam.nowak@gmail.com','hash_009','+48509012989','Lublin'),
('Maria','Garcia','maria.garcia@gmail.com','hash_010','+48510123090','Szczecin');


insert into clinics (name,address,city,phone,email,opening_time,closing_time)
VALUES
('Happy Paws Veterinary Clinic','Piotrkowska 120','Lodz','+48421234567','happypaws@gmail.com','08:00','18:00'),
('Animal Care Center','Marszalkowska 45','Warsaw','+48221234567','animalcare@gmail.com','09:00','19:00'),
('VetMed Clinic','Dluga 25','Krakow','+48121234567','vetmed@gmail.com','08:00','17:00'),
('Healthy Pets Clinic','Swidnicka 30','Wroclaw','+48711234567','healthypets@gmail.com','09:00','18:00'),
('PetLife Veterinary Center','Glogowska 80','Poznan','+48611234567','petlife@gmail.com','08:00','18:00'),
('Baltic Vet Clinic','Dluga 15','Gdansk','+48581234567','balticvet@gmail.com','10:00','20:00');

insert into veterinarians (clinic_id,first_name,last_name,specialization,phone,email,years_of_experience,license_number)
values
(1,'Robert','Smith','Surgery','+48421234001','robert.smith@vetcare.com',12,'LIC1001'),
(1,'Emily','Clark','Dermatology','+48421234002','emily.clark@vetcare.com',8,'LIC1002'),
(2, 'James', 'Wilson', 'Internal Medicine', '+48221234003', 'james.wilson@vetcare.com', 15, 'LIC1003'),
(2, 'Laura', 'Brown', 'Surgery', '+48221234004', 'laura.brown@vetcare.com', 10, 'LIC1004'),
(3, 'Thomas', 'Miller', 'Cardiology', '+48121234005', 'thomas.miller@vetcare.com', 7, 'LIC1005'),
(4, 'Sophie', 'Anderson', 'Dermatology', '+48711234006', 'sophie.anderson@vetcare.com', 9, 'LIC1006'),
(4, 'Daniel', 'Taylor', 'Orthopedics', '+48711234007', 'daniel.taylor@vetcare.com', 14, 'LIC1007'),
(5, 'Anna', 'Davis', 'Internal Medicine', '+48611234008', 'anna.davis@vetcare.com', 6, 'LIC1008'),
(6, 'Michael', 'Moore', 'Surgery', '+48581234009', 'michael.moore@vetcare.com', 11, 'LIC1009'),
(6, 'Olivia', 'Martin', 'Dentistry', '+48581234010', 'olivia.martin@vetcare.com', 5, 'LIC1010');


insert into pets (owner_id,name,species,breed,gender,birth_date,weight_kg,color,microchip_number)
VALUES
(1,'Max','Dog','German Shepherd','Male','2020-05-12',32.50,'Black','MC100001'),
(1,'Luna','Cat','British Shorthair','Female','2022-08-20',4.80,'Gray','MC100002'),
(2, 'Bella', 'Dog', 'Golden Retriever', 'Female', '2019-03-15', 28.70, 'Golden', 'MC100003'),
(3, 'Charlie', 'Dog', 'Beagle', 'Male', '2021-06-10', 12.40, 'Brown', 'MC100004'),
(3, 'Milo', 'Cat', 'Maine Coon', 'Male', '2020-11-05', 7.20, 'White', 'MC100005'),
(4, 'Daisy', 'Dog', 'French Bulldog', 'Female', '2022-01-18', 11.30, 'Cream', 'MC100006'),
(5, 'Rocky', 'Dog', 'Rottweiler', 'Male', '2018-09-25', 42.60, 'Black', 'MC100007'),
(6, 'Coco', 'Cat', 'Persian', 'Female', '2021-12-03', 5.10, 'White', 'MC100008'),
(7, 'Bruno', 'Dog', 'Labrador', 'Male', '2020-04-22', 30.80, 'Black', 'MC100009'),
(8, 'Nala', 'Cat', 'Siamese', 'Female', '2023-02-14', 3.90, 'Cream', 'MC100010'),
(9, 'Oscar', 'Dog', 'Poodle', 'Male', '2019-07-30', 9.60, 'White', 'MC100011'),
(10, 'Ruby', 'Dog', 'Cocker Spaniel', 'Female', '2021-10-11', 13.20, 'Brown', 'MC100012');

insert into vaccinations (pet_id,vaccine_name,vaccination_date,next_due_date,veterinarian_id,notes)
VALUES
(1,'Rabies','2025-02-10','2026-02-10',1,'Annual rabies vaccination'),
(1, 'DHPP', '2025-03-15', '2026-03-15', 2, 'Booster dose'),
(2, 'FVRCP', '2025-04-20', '2026-04-20', 2, 'Regular vaccination'),
(3, 'Rabies', '2025-01-12', '2026-01-12', 3, 'Annual vaccination'),
(4, 'DHPP', '2025-05-05', '2026-05-05', 4, 'Booster dose'),
(5, 'FVRCP', '2025-06-18', '2026-06-18', 5, 'Regular vaccination'),
(6, 'Rabies', '2025-02-25', '2026-02-25', 6, 'Annual rabies vaccination'),
(7, 'DHPP', '2025-03-30', '2026-03-30', 7, 'Booster dose'),
(8, 'FVRCP', '2025-07-10', '2026-07-10', 6, 'Regular vaccination'),
(9, 'Rabies', '2025-01-25', '2026-01-25', 9, 'Annual vaccination'),
(10, 'FVRCP', '2025-08-15', '2026-08-15', 10, 'First vaccination'),
(11, 'Rabies', '2025-04-08', '2026-04-08', 9, 'Annual vaccination');


insert into pet_health_records (pet_id,veterinarian_id,record_date,diagnosis,symptoms,treatment,notes)
VALUES
(1,1,'2025-02-10','Routine health check','None','None','Healthy and active'),
(1,1,'2025-06-12','Skin irritation','Itching and redness','Topical treatment','Follow-up in 2 weeks'),
(2,2,'2025-04-20','Routine check-up','None','None','Healthy'),
(3,3,'2025-01-12','Ear infection','Head shaking and scratching','Ear drops','Recheck after 10 days'),
(4,4,'2025-05-05','Dental tartar','Bad breath','Dental cleaning recommended','Monitor dental health'),
(5,5,'2025-06-18','Routine health check','None','None','Weight normal'),
(6,6,'2025-02-25','Allergy','Sneezing and itching','Antihistamine','Seasonal symptoms'),
(7,7,'2025-03-30','Joint pain','Difficulty walking','Anti-inflammatory medication','Limit intense exercise'),
(8,6,'2025-07-10','Routine check-up','None','None','Healthy'),
(9,9,'2025-01-25','Overweight','Low activity','Diet plan','Weight monitoring recommended'),
(10,10,'2025-08-15','Routine health check','None','None','Healthy'),
(11,9,'2025-04-08','Minor stomach upset','Vomiting and reduced appetite','Diet adjustment','Symptoms resolved'),
(12,10,'2025-09-01','Routine health check','None','None','Healthy');


insert into vet_appointments (pet_id,veterinarian_id,appointment_date,appointment_time,reason,status,notes)
VALUES
(1,1,'2025-03-05','10:00','Routine health examination','Completed','Regular annual check-up'),
(2,2,'2025-04-22','11:30','Vaccination','Completed','FVRCP vaccination'),
(3,3,'2025-05-15','14:00','Ear problem','Completed','Ear infection examination'),
(4,4,'2025-06-10','09:30','Dental examination','Completed','Dental tartar check'),
(5,5,'2025-06-25','15:00','Routine check-up','Completed','General health examination'),
(6,6,'2025-07-08','10:30','Allergy symptoms','Completed','Allergy examination'),
(7,7,'2025-07-20','13:00','Joint pain','Completed','Mobility examination'),
(8,6,'2025-08-05','11:00','Routine health examination','Completed','General check-up'),
(9,9,'2025-08-18','16:00','Weight problem','Completed','Weight and diet consultation'),
(10,10,'2025-09-10','12:30','Vaccination','Confirmed','FVRCP vaccination'),
(11,9,'2025-09-15','10:00','Stomach problem','Pending','Follow-up examination'),
(12,10,'2025-09-20','14:30','Routine health examination','Confirmed','Annual check-up');


insert into products (name,category,description,price,stock_quantity,brand,is_active)
VALUES
('Premium Dog Food','Food','High-quality dry food for adult dogs',89.99,50,'Royal Canin',TRUE),
('Cat Dry Food','Food','Balanced dry food for adult cats',69.99,40,'Purina',TRUE),
('Dental Chew Sticks','Treats','Dental treats for dogs',24.50,80,'Pedigree',TRUE),
('Cat Scratching Post','Accessories','Medium scratching post for cats',59.99,25,'Trixie',TRUE),
('Dog Shampoo','Hygiene','Gentle shampoo for sensitive dog skin',32.90,35,'Beaphar',TRUE),
('Flea and Tick Collar','Health','Protection against fleas and ticks',45.00,60,'Seresto',TRUE),
('Pet Vitamins','Supplements','Daily multivitamins for dogs and cats',39.90,45,'VetExpert',TRUE),
('Interactive Cat Toy','Toys','Interactive toy for indoor cats',29.99,30,'Trixie',TRUE),
('Dog Leash','Accessories','Strong nylon leash for daily walks',35.50,55,'Flexi',TRUE),
('Pet First Aid Kit','Health','Basic first aid kit for pets',74.99,20,'Trixie',TRUE),
('Ceramic Food Bowl','Accessories','Non-slip ceramic bowl for pets',27.90,40,'Hunter',TRUE),
('Puppy Training Pads','Hygiene','Absorbent training pads for puppies',34.99,70,'Simple Solution',TRUE);

insert into orders (user_id,order_date,status,shipping_address,total_amount)
VALUES
(1,'2025-09-01 10:15:00','Completed','Lodz, Piotrkowska 10',179.98),
(2,'2025-09-03 14:20:00','Completed','Warsaw, Marszalkowska 25',94.49),
(3,'2025-09-05 09:30:00','Pending','Krakow, Dluga 15',129.98),
(4,'2025-09-07 16:45:00','Shipped','Wroclaw, Swidnicka 20',59.99),
(5,'2025-09-10 11:10:00','Completed','Poznan, Glogowska 35',84.90),
(6,'2025-09-12 13:25:00','Cancelled','Gdansk, Dluga 40',45.00),
(7,'2025-09-15 15:40:00','Completed','Lodz, Piotrkowska 80',134.99),
(8,'2025-09-18 10:05:00','Shipped','Katowice, Warszawska 12',99.90),
(9,'2025-09-20 12:30:00','Pending','Lublin, Krakowskie Przedmiescie 18',74.99),
(10,'2025-09-22 17:15:00','Completed','Szczecin, Dluga 22',109.99);


insert into order_items (order_id,product_id,quantity,unit_price)
VALUES
(1,1,2,89.99),
(1,3,1,24.50),
(2,5,1,32.90),
(2,7,1,39.90),
(3,2,1,69.99),
(3,4,1,59.99),
(4,4,1,59.99),
(5,6,1,45.00),
(5,11,1,27.90),
(6,6,1,45.00),
(7,1,1,89.99),
(7,3,1,24.50),
(8,7,1,39.90),
(8,8,2,29.99),
(9,10,1,74.99),
(10,9,1,35.50),
(10,12,1,34.99);


