require 'bookings'
require 'database_helpers'

describe Bookings do
  describe '.from_user' do
    it 'returns an array of bookings from a user' do
      Bookings.create(booker_id: 4, space_id: 7, space_name: 'Place', owner_id: 8, confirmed: false, date: Date.new(2022, 11, 04))
      
      Bookings.create(booker_id: 1, space_id: 2, space_name: 'Place', owner_id: 3, confirmed: false, date: Date.new(2022, 12, 02))

      Bookings.create(booker_id: 4, space_id: 5, space_name: 'Place', owner_id: 6, confirmed: false, date: Date.new(2022, 10, 03))

      bookings = Bookings.from_user(user_id: 4)
      
      expect(bookings[0].booker_id).to eq 4
      expect(bookings[1].booker_id).to eq 4
    end
  end

  describe '.to_user' do
    it 'returns an array of booking to a user' do
      Bookings.create(booker_id: 4, space_id: 7, space_name: 'Place', owner_id: 8, confirmed: false, date: Date.new(2022, 11, 04))
      
      Bookings.create(booker_id: 1, space_id: 2, space_name: 'Place', owner_id: 3, confirmed: false, date: Date.new(2022, 12, 02))

      Bookings.create(booker_id: 9, space_id: 5, space_name: 'Place', owner_id: 8, confirmed: false, date: Date.new(2022, 10, 03))

      bookings = Bookings.to_user(user_id: 8)
      
      expect(bookings[0].owner_id).to eq 8
      expect(bookings[1].owner_id).to eq 8
    end
  end

  describe '.find' do
    it 'finds a space by id' do
      booking = Bookings.create(booker_id: 5, space_id: 2, space_name: 'Seaside Space', owner_id: 3, confirmed: false, date: Date.new(2022, 12, 02))

      request_id = Bookings.from_user(user_id: 5)[0].id

      found_booking = Bookings.find(id: request_id)

      expect(found_booking.space_name).to eq 'Seaside Space'
    end
  end

  describe '#confirm' do
    it 'changes confirmed status to Booking Confirmed' do
      Bookings.create(booker_id: 13, space_id: 11, space_name: 'Seaside Space', owner_id: 3, confirmed: 'Not Confirmed', date: Date.new(2022, 12, 02))

      booking = Bookings.from_user(user_id: 13)[0]

      booking.confirm

      expect(booking.confirmed).to eq 'Booking Confirmed'
    end
  end

  describe '#deny' do
    it 'changes confirmed status to Booking Denied' do

    end
  end
end
