CREATE TABLE bookings(id SERIAL PRIMARY KEY, booker_id INTEGER, space_id INTEGER, space_name VARCHAR(100), owner_id INTEGER, confirmed VARCHAR(30),  check_in DATE, check_out DATE);
