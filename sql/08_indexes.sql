-- Query 1: Create an index on the pets owner_id column.   --drop INDEX indx_pets;
create INDEX indx_pets on pets(owner_id);   

-- Query 2: Create an index on the veterinarian_id column of vet_appointments.
create INDEX indx_vet_appointments on vet_appointments(veterinarian_id);  --explain ANALYSE select * from vet_appointments where veterinarian_id = 5;

-- Query 3: Create an index on the appointment_date column of vet_appointments.
create index indx_vet_app on vet_appointments(appointment_date);  --explain analyze select * from vet_appointments where appointment_date <= current_date;

-- Query 4: Create a composite index on veterinarian_id and appointment_date.
create index indx_vet_appoint on vet_appointments(veterinarian_id, appointment_date);   --explain analyze SELECT * FROM vet_appointments WHERE veterinarian_id = 3 AND appointment_date >= CURRENT_DATE;

-- Query 5: Create a partial index for pending appointments.
create index indx_va on vet_appointments(appointment_date) where status = 'Pending';

-- Query 6: Use EXPLAIN ANALYZE to check whether PostgreSQL uses an index for searching pets by owner_id.
explain ANALYSE select * from pets where owner_id = 3;
