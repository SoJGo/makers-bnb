CREATE TABLE bookings(id SERIAL PRIMARY KEY, booker_id INTEGER, space_id INTEGER, owner_id INTEGER, confirmed BOOLEAN,  date DATE);
