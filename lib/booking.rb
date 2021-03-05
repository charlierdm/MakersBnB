require 'pg'
require_relative 'sql_connections'

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

class << self

  def confirm(id:)
    Connection.exec("UPDATE bookings SET booking_status='confirmed', available='0' WHERE id = #{id};")
  end

  def deny(id:)
    Connection.exec("UPDATE bookings SET booking_status='denied' WHERE id = #{id};")
  end

  def check_available(space_id:, date:)
    result = Connection.exec("SELECT * FROM bookings WHERE space_id = '#{space_id}' AND date = '#{date}' AND available = '#{0}'")
    result.any?
  end

    # if result is empty, then space is available, therefore create booking.
    # if results has something in it, space is unavailable, therefore don't create Booking.new

  def find(id:)
    result = Connection.exec("SELECT * FROM bookings WHERE id = #{id};")
    Booking.new(id: result[0]['id'], space_id: result[0]['space_id'], user_id: result[0]['user_id'], date: result[0]['date'], booking_status: result[0]['booking_status'], available: result[0]['available'])
  end

    def create(space_id:, user_id:, date:, booking_status:, available:)
      result = Connection.exec("INSERT INTO bookings (space_id, user_id, date, booking_status, available) VALUES(#{space_id}, #{user_id}, '#{date}', '#{booking_status}', '#{available}') RETURNING *;")
      Booking.new(id: result[0]['id'], space_id: result[0]['space_id'], user_id: result[0]['user_id'], date: result[0]['date'], booking_status: result[0]['booking_status'], available: result[0]['available'])
    end

    def find_requests_made(user_id:)
      result = Connection.exec("SELECT * FROM bookings WHERE user_id='#{user_id.to_i}' ;")
      result.map do |booking|
        Booking.new(id: booking['id'], space_id: booking['space_id'], user_id: booking['user_id'], date: booking['date'], booking_status: booking['booking_status'], available: booking['available'])
      end
    end

    def find_request_received(user_id:)
      results = Connection.exec("SELECT bookings.id, bookings.user_id, bookings.date, bookings.space_id, bookings.booking_status, bookings.available FROM bookings INNER JOIN spaces ON bookings.space_id = spaces.id WHERE spaces.user_id = #{user_id};")
      results.map do |booking|
        Booking.new(id: booking['id'], space_id: booking['space_id'], user_id: booking['user_id'], date: booking['date'], booking_status: booking['booking_status'], available: booking['available'])
      end
    end

    def find_unavailable(space_id:)
      result = Connection.exec("SELECT * FROM bookings WHERE space_id = '#{space_id}' AND available = '#{0}';")
      result.map do |bookings|
        Booking.new(id: bookings['id'], space_id: bookings['space_id'], user_id: bookings['user_id'], date: bookings['date'], booking_status: bookings['booking_status'], available: bookings['available'])
      end
    end

  end
end
