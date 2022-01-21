require 'bookings'
require 'database_helpers'

describe Bookings do
  describe '.from_user' do
    it 'returns an array of bookings from a user' do
      Bookings.create(booker_id: 4, space_id: 7, space_name: 'Place', owner_id: 8, confirmed: false, check_in: Date.new(2022, 11, 04), check_out: Date.new(2022, 12, 05))

      
      Bookings.create(booker_id: 1, space_id: 2, space_name: 'Place', owner_id: 3, confirmed: false, check_in: Date.new(2022, 12, 02), check_out: Date.new(2022, 12, 05))


      Bookings.create(booker_id: 4, space_id: 5, space_name: 'Place', owner_id: 6, confirmed: false, check_in: Date.new(2022, 10, 03), check_out: Date.new(2022, 12, 05))


      bookings = Bookings.from_user(user_id: 4)
      
      expect(bookings[0].booker_id).to eq 4
      expect(bookings[1].booker_id).to eq 4
      expect(bookings.length).to eq 2
    end
  end

  describe '.to_user' do
    it 'returns an array of booking to a user' do
      Bookings.create(booker_id: 4, space_id: 7, space_name: 'Place', owner_id: 8, confirmed: false, check_in: Date.new(2022, 11, 04), check_out: Date.new(2022, 12, 05))

      
      Bookings.create(booker_id: 1, space_id: 2, space_name: 'Place', owner_id: 3, confirmed: false, check_in: Date.new(2022, 12, 02), check_out: Date.new(2022, 12, 05))


      Bookings.create(booker_id: 9, space_id: 5, space_name: 'Place', owner_id: 8, confirmed: false, check_in: Date.new(2022, 10, 03), check_out: Date.new(2022, 12, 05))


      bookings = Bookings.to_user(user_id: 8)
      
      expect(bookings[0].owner_id).to eq 8
      expect(bookings[1].owner_id).to eq 8
      expect(bookings.length).to eq 2
    end
  end

  describe '.by_space' do
    it 'returns an array of bookings by space' do
      Bookings.create(booker_id: 4, space_id: 9, space_name: 'Place 1', owner_id: 8, confirmed: false, check_in: Date.new(2022, 11, 04), check_out: Date.new(2022, 12, 05))

      
      Bookings.create(booker_id: 1, space_id: 6, space_name: 'Other Place', owner_id: 3, confirmed: false, check_in: Date.new(2022, 12, 02), check_out: Date.new(2022, 12, 05))


      Bookings.create(booker_id: 9, space_id: 9, space_name: 'Place 2', owner_id: 8, confirmed: false, check_in: Date.new(2022, 10, 03), check_out: Date.new(2022, 12, 05))

      Bookings.create(booker_id: 6, space_id: 9, space_name: 'Place 3', owner_id: 8, confirmed: false, check_in: Date.new(2022, 10, 03), check_out: Date.new(2022, 12, 05))


      bookings = Bookings.by_space(space_id: 9)
      
      expect(bookings[0].space_id).to eq 9
      expect(bookings[1].space_id).to eq 9
      expect(bookings[2].space_id).to eq 9
      expect(bookings.length).to eq 3
    end
  end

  describe '.find' do
    it 'finds a space by id' do
      booking = Bookings.create(booker_id: 5, space_id: 2, space_name: 'Seaside Space', owner_id: 3, confirmed: false, check_in: Date.new(2022, 12, 02), check_out: Date.new(2022, 12, 05))


      request_id = Bookings.from_user(user_id: 5)[0].id

      found_booking = Bookings.find(id: request_id)

      expect(found_booking.space_name).to eq 'Seaside Space'
    end
  end

  describe '#confirm' do
    it 'changes confirmed status to Booking Confirmed' do
      Bookings.create(booker_id: 13, space_id: 11, space_name: 'Seaside Space', owner_id: 3, confirmed: 'Not Confirmed', check_in: Date.new(2022, 12, 02), check_out: Date.new(2022, 12, 05))


      booking = Bookings.from_user(user_id: 13)[0]
      booking.confirm
      confirmed_booking = Bookings.from_user(user_id: 13)[0]

      expect(confirmed_booking.confirmed).to eq 'Booking Confirmed'
    end
  end

  describe '#deny' do
    it 'changes confirmed status to Booking Denied' do
      Bookings.create(booker_id: 17, space_id: 11, space_name: 'Seaside Space', owner_id: 3, confirmed: 'Not Confirmed', check_in: Date.new(2022, 12, 02), check_out: Date.new(2022, 12, 05))

      booking = Bookings.from_user(user_id: 17)[0]
      booking.deny
      denied_booking = Bookings.from_user(user_id: 17)[0]

      expect(denied_booking.confirmed).to eq 'Booking Denied'
    end
  end
end
