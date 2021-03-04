require 'pg'

class Booking

  attr_reader :id, :space_id, :user_id, :date, :booking_status, :available

  def initialize(id:, space_id:, user_id:, date:, booking_status:, available:)
    @id = id
    @space_id = space_id
    @user_id = user_id
    @date = date
    @booking_status = booking_status
    @available = available
  end

  def confirm(id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    connection.exec("UPDATE bookings SET booking_status='confirmed', available='0' WHERE id = #{id};")
    connection.close()
  end

class << self

  def create(space_id:, user_id:, date:, booking_status:, available:)
    connection = make_connection()
    result = connection.exec("INSERT INTO bookings (space_id, user_id, date, booking_status, available) VALUES('#{space_id}', '#{user_id}', '#{date}', '#{booking_status}', '#{available}') RETURNING *;")
    connection.close()
    Booking.new(id: result[0]['id'], space_id: result[0]['space_id'], user_id: result[0]['user_id'], date: result[0]['date'], booking_status: result[0]['booking_status'], available: result[0]['available'])
  end

  def find_requests_made(user_id:)
    connection = make_connection()
    result = connection.exec("SELECT * FROM bookings WHERE user_id='#{user_id.to_i}' ;")
    connection.close()
    result.map do |booking|
      Booking.new(id: booking['id'], space_id: booking['space_id'], user_id: booking['user_id'], date: booking['date'], booking_status: booking['booking_status'], available: booking['available'])
    end
  end

  def find_request_received(user_id:)
    connection = make_connection()

    results = connection.exec("SELECT bookings.id, bookings.user_id, bookings.date, bookings.space_id, bookings.booking_status, bookings.available FROM bookings INNER JOIN spaces ON bookings.space_id = spaces.id WHERE spaces.user_id = '#{user_id}';")
    results.map do |booking|
      Booking.new(id: booking['id'], space_id: booking['space_id'], user_id: booking['user_id'], date: booking['date'], booking_status: booking['booking_status'], available: booking['available'])
    end
  end


  private

    def make_connection
      if ENV['ENVIRONMENT'] == 'test'
        return PG.connect(dbname: 'makersbnb_test')
      else
        return PG.connect(dbname: 'makersbnb')
      end
    end

  end

end
