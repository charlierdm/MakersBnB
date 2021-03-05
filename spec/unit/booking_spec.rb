require 'booking'

describe Booking do

  it 'creates a new booking' do
    booking = Booking.create(space_id: "200", date: "2021-03-03", user_id: 1, booking_status: "pending", available: "1")

    expect(booking).to be_a Booking
    expect(booking.space_id).to eq("200")
    expect(booking.date).to eq("2021-03-03")
    expect(booking.user_id).to eq('1')
    expect(booking.booking_status).to eq("pending")
    expect(booking.available).to eq("1")
  end

  it 'finds all bookings for a space' do
    test_booking = Booking.create(space_id: "200", date: "2021-03-03", user_id: 1, booking_status: "pending", available: "1")
    test_booking_2 = Booking.create(space_id: "200", date: "2021-03-05", user_id: 1, booking_status: "pending", available: "1")
    test_booking_3 = Booking.create(space_id: "200", date: "2021-03-06", user_id: 1, booking_status: "pending", available: "1")

    Booking.confirm(id: test_booking.id)
    Booking.confirm(id: test_booking_2.id)
    booking = Booking.find_unavailable(space_id: "200")
    p booking

    #Tests that unconfirmed bookings aren't being found as unavilable.
    expect(booking.length).to eq(2)
    # Tests for unavailable date
    expect(booking[0].space_id).to eq("200")
    expect(booking[0].date).to eq("2021-03-03")
    expect(booking[0].user_id).to eq('1')
    expect(booking[0].booking_status).to eq("confirmed")
    expect(booking[0].available).to eq("0")
    # Tests for second unavilable date
    expect(booking[1].space_id).to eq("200")
    expect(booking[1].date).to eq("2021-03-05")
    expect(booking[1].user_id).to eq('1')
    expect(booking[1].booking_status).to eq("confirmed")
    expect(booking[1].available).to eq("0")


  end

   it 'confirms a booking request' #do
   #Test needs a specific booking id to work -> unsure how to do that at the moment
  #
  #   fake_booking.confirm(id: "299")
  #   expect(fake_booking.booking_status).to eq("confirmed")
  #   expect(fake_booking.available).to eq("0")
  # end

end
