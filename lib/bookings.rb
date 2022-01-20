require_relative 'database_connection'

class Bookings
  attr_reader :booker_id, :space_id, :owner_id, :confirmed, :date

  def initialize(booker_id:, space_id:, owner_id:, confirmed:, date:)
    @booker_id = booker_id.to_i
    @space_id = space_id.to_i
    @owner_id = owner_id.to_i
    @confirmed = confirmed
    @date = date
  end

  def self.create(booker_id:, space_id:, owner_id:, confirmed:, date:)
    result = DatabaseConnection.query("INSERT INTO bookings(booker_id, space_id, owner_id, confirmed, date) VALUES ($1, $2, $3, $4, $5);",
      [booker_id, space_id, owner_id, confirmed, date]
    )
  end

  def self.from_user(user_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE booker_id = $1;", [user_id])
    
    result.map do |booking|
      Bookings.new(booker_id: booking['booker_id'], space_id: booking['space_id'], owner_id: booking['owner_id'], confirmed: booking['confirmed'], date: booking ['date'])
    end
  end

  def self.to_user(user_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE owner_id = $1;", [user_id])
    
    result.map do |booking|
      Bookings.new(booker_id: booking['booker_id'], space_id: booking['space_id'], owner_id: booking['owner_id'], confirmed: booking['confirmed'], date: booking ['date'])
    end
  end
end 
