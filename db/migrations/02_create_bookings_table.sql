CREATE TABLE bookings(id SERIAL PRIMARY KEY, booker_id INTEGER, space_id INTEGER, space_name VARCHAR(100), owner_id INTEGER, confirmed BOOLEAN,  date DATE);
