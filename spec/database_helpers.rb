require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'makers_bnb_test')
  result = connection.exec("SELECT * FROM spaces WHERE id = '#{id}';")
  result.first
end
