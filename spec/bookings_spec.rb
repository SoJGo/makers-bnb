require 'bookings'
require 'database_helpers'

describe Bookings do
  
  describe '.create' do
    it 'creates a booking for a space' do
      booking = Bookings.create(booker_id: 1, space_id: 2, owner_id: 3, confirmed: FALSE, date: )
    end 
  end
end 
