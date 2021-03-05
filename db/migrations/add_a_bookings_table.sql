CREATE TABLE bookings (id SERIAL PRIMARY KEY, date DATE, space_id INT, user_id INT, booking_status VARCHAR(100), available BIT);

-- recreate the table with space_id as an INTEGER datatype
