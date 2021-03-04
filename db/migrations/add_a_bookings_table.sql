CREATE TABLE bookings (id SERIAL PRIMARY KEY, date DATE, space_id VARCHAR(100), user_id VARCHAR(200), booking_status VARCHAR(100), available BIT);
