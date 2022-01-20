require 'pg'

def persisted_data(table:)
  connection = PG.connect(dbname: 'makers_bnb_test')
  result = connection.exec("SELECT * FROM #{table};")
  result[0]
end
