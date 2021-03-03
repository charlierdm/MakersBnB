require 'pg'

class Booking

  attr_reader :space_id, :user_id, :date, :booking_status, :available

  def initialize(space_id:, user_id:, date:, booking_status:, available:)
    @space_id = space_id
    @user_id = user_id
    @date = date
    @booking_status = booking_status
    @available = available
  end

class << self

  def create(space_id:, user_id:, date:, booking_status:, available:)
    connection = make_connection()
    result = connection.exec("INSERT INTO bookings (space_id, user_id, date, booking_status, available) VALUES('#{space_id}', '#{user_id}', '#{date}', '#{booking_status}', '#{available}') RETURNING *;")
    Booking.new(space_id: result[0]['space_id'], user_id: result[0]['user_id'], date: result[0]['date'], booking_status: result[0]['booking_status'], available: result[0]['available'])
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
