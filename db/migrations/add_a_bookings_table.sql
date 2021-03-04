CREATE TABLE bookings (id SERIAL PRIMARY KEY, date DATE, space_id INT, user_id VARCHAR(200), booking_status VARCHAR(100), available BIT);

-- recreate the table with space_id as an INTEGER datatype
