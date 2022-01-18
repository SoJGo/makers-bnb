require 'pg'

def persisted_data(table:, id:)
  connection = PG.connect(dbname: 'makers_bnb')
  result = connection.query("SELECT * FROM #{table} WHERE id = #{id};")
  result.first
end
