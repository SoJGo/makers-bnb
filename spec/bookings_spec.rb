require 'bookings'
require 'database_helpers'

describe Bookings do
  
  describe '.create' do
    it 'creates a booking for a space' do
      booking = Bookings.create
    end 
  end
end 
