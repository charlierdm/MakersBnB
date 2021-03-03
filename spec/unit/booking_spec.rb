require 'booking'

describe Booking do

  it 'creates a new booking' do
    booking = Booking.create(space_id: "200", date: "2021-03-03", user_id: "user_1", booking_status: "pending", available: "1")

    expect(booking).to be_a Booking
    expect(booking.space_id).to eq("200")
    expect(booking.date).to eq("2021-03-03")
    expect(booking.user_id).to eq("user_1")
    expect(booking.booking_status).to eq("pending")
    expect(booking.available).to eq("1")
  end


end
