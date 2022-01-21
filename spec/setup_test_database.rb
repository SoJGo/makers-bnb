require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec("TRUNCATE spaces, users, bookings RESTART IDENTITY;")
end
