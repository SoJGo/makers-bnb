require_relative 'database_connection'

class Bookings
  attr_reader :id, :booker_id, :space_id, :space_name, :owner_id, :confirmed, :check_in, :check_out

  def initialize(id:, booker_id:, space_id:, space_name:, owner_id:, confirmed:, check_in:, check_out:)
    @id = id.to_i
    @booker_id = booker_id.to_i
    @space_id = space_id.to_i
    @space_name = space_name
    @owner_id = owner_id.to_i
    @confirmed = confirmed
    @check_in = check_in
    @check_out = check_out
  end

  def self.create(booker_id:, space_id:, space_name:, owner_id:, confirmed:, check_in:, check_out:)
    result = DatabaseConnection.query("INSERT INTO bookings(booker_id, space_id, space_name, owner_id, confirmed, check_in, check_out) VALUES ($1, $2, $3, $4, $5, $6, $7);",
      [booker_id, space_id, space_name, owner_id, confirmed, check_in, check_out]
    )
  end

  def self.from_user(user_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE booker_id = $1;", [user_id])
    
    result.map do |booking|
      Bookings.new(id: booking['id'], booker_id: booking['booker_id'], space_id: booking['space_id'], space_name: booking['space_name'], owner_id: booking['owner_id'], confirmed: booking['confirmed'], check_in: booking['check_in'], check_out: booking['check_out'])
    end
  end

  def self.to_user(user_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE owner_id = $1;", [user_id])
    
    result.map do |booking|
      Bookings.new(id: booking['id'], booker_id: booking['booker_id'], space_id: booking['space_id'], space_name: booking['space_name'], owner_id: booking['owner_id'], confirmed: booking['confirmed'], check_in: booking['check_in'], check_out: booking['check_out'])
    end
  end

  def self.by_space(space_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE space_id = $1;", [space_id])
    
    result.map do |booking|
      Bookings.new(id: booking['id'], booker_id: booking['booker_id'], space_id: booking['space_id'], space_name: booking['space_name'], owner_id: booking['owner_id'], confirmed: booking['confirmed'], check_in: booking['check_in'], check_out: booking['check_out'])
    end
  end

  def self.find(id:)
    booking_id = id.to_i

    booking = DatabaseConnection.query("SELECT * FROM bookings WHERE id = $1;", [booking_id])
   
    Bookings.new(id: booking[0]['id'], booker_id: booking[0]['booker_id'], space_id: booking[0]['space_id'], space_name: booking[0]['space_name'], owner_id: booking[0]['owner_id'], confirmed: booking[0]['confirmed'], check_in: booking[0]['check_in'], check_out: booking[0]['check_out'])
  end

  def self.check_dates_availability(spaces:, check_in:, check_out:)
    available = []
    conflicts = []

    spaces.each do |space|
      bookings_per_space  = DatabaseConnection.query(
        "SELECT * FROM bookings WHERE space_id = $1 AND confirmed = $2;", 
        [space.id, 'Booking Confirmed']
      )

      bookings_per_space.each do |booking|
        if check_in < booking['check_out'] && check_out > booking['check_in']
          conflicts << booking
        end
      end

      if conflicts.empty? && check_in >= space.start_date && check_out <= space.end_date
        available << space
      end

      conflicts = []
    end

    available
  end

  def self.check_all_availability(spaces:)
    available = []
    conflicts = []

    spaces.each do |space|
      bookings_per_space  = DatabaseConnection.query(
        "SELECT * FROM bookings WHERE space_id = $1 AND confirmed = $2;", 
        [space.id, 'Booking Confirmed']
      )

      bookings_per_space.each do |booking|
        if space.start_date >= booking['check_in'] && space.end_date <= booking['check_out']
          conflicts << booking
        end
      end

      if conflicts.empty?
        available << space
      end

      conflicts = []
    end

    available
  end

  def confirm
    DatabaseConnection.query(
      "UPDATE bookings SET confirmed = 'Booking Confirmed' WHERE id = $1;", 
      [self.id]
    )
  end

  def deny
    DatabaseConnection.query(
      "UPDATE bookings SET confirmed = 'Booking Denied' WHERE id = $1;", 
      [self.id]
    )
  end
end
