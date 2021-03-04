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
  end


class << self

  def create(space_id:, user_id:, date:, booking_status:, available:)
    connection = make_connection()
    result = connection.exec("INSERT INTO bookings (space_id, user_id, date, booking_status, available) VALUES('#{space_id}', '#{user_id}', '#{date}', '#{booking_status}', '#{available}') RETURNING *;")
    Booking.new(id: result[0]['id'], space_id: result[0]['space_id'], user_id: result[0]['user_id'], date: result[0]['date'], booking_status: result[0]['booking_status'], available: result[0]['available'])
  end

  def find_unavailable(space_id:)
    connection = make_connection()
    result = connection.exec("SELECT * FROM bookings WHERE space_id = '#{space_id}' AND available = '#{0}';")
    result.map do |bookings|
      Booking.new(id: bookings['id'], space_id: bookings['space_id'], user_id: bookings['user_id'], date: bookings['date'], booking_status: bookings['booking_status'], available: bookings['available'])
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
