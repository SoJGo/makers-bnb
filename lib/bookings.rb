require_relative 'database_connection'

class Bookings

  def self.create(booker_id:, space_id:, owner_id:, confirmed:, date:)
    result = DatabaseConnection.query("INSERT INTO bookings(booker_id, space_id, owner_id, confirmed, date) VALUES ($1, $2, $3, $4, $5);",
      [booker_id, space_id, owner_id, confirmed, date]
    )
  end 
end 
