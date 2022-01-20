require_relative 'database_connection'

class Bookings
  attr_reader :id, :booker_id, :space_id, :space_name, :owner_id, :confirmed, :date

  def initialize(id:, booker_id:, space_id:, space_name:, owner_id:, confirmed:, date:)
    @id = id.to_i
    @booker_id = booker_id.to_i
    @space_id = space_id.to_i
    @space_name = space_name
    @owner_id = owner_id.to_i
    @confirmed = confirmed
    @date = date
  end

  def self.create(booker_id:, space_id:, space_name:, owner_id:, confirmed:, date:)
    result = DatabaseConnection.query("INSERT INTO bookings(booker_id, space_id, space_name, owner_id, confirmed, date) VALUES ($1, $2, $3, $4, $5, $6);",
      [booker_id, space_id, space_name, owner_id, confirmed, date]
    )
  end

  def self.from_user(user_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE booker_id = $1;", [user_id])
    
    result.map do |booking|
      Bookings.new(id: booking['id'], booker_id: booking['booker_id'], space_id: booking['space_id'], space_name: booking['space_name'], owner_id: booking['owner_id'], confirmed: booking['confirmed'], date: booking ['date'])
    end
  end

  def self.to_user(user_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE owner_id = $1;", [user_id])
    
    result.map do |booking|
      Bookings.new(id: booking['id'], booker_id: booking['booker_id'], space_id: booking['space_id'], space_name: booking['space_name'], owner_id: booking['owner_id'], confirmed: booking['confirmed'], date: booking ['date'])
    end
  end

  def self.find(id:)
    booking_id = id.to_i

    booking = DatabaseConnection.query("SELECT * FROM bookings WHERE id = $1;", [booking_id])
   
    Bookings.new(id: booking[0]['id'], booker_id: booking[0]['booker_id'], space_id: booking[0]['space_id'], space_name: booking[0]['space_name'], owner_id: booking[0]['owner_id'], confirmed: booking[0]['confirmed'], date: booking[0]['date'])
  end 
end 
