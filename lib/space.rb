require 'pg'

class Space

  attr_reader :id, :name, :description, :user_id, :price, :available_from, :available_to

  def initialize(id:, name:, description:, user_id:, price:, available_from:, available_to:)
    @id = id
    @name = name
    @description = description
    @user_id = user_id
    @price = price
    @available_from = available_from
    @available_to = available_to
  end


  class << self

    def all # identical to self.all
      connection = make_connection()
      result = connection.exec("SELECT * FROM spaces;")
      result.map do |space|
        Space.new(id: space['id'], name: space['name'], description: space['description'], user_id: space['user_id'], price: space['price'], available_from: space['available_from'], available_to: space['available_to'])
      end
    end

    def create(name:, description:, user_id:, price:, available_from:, available_to:)
      connection = make_connection()
      result = connection.exec("INSERT INTO spaces (name, description, user_id, price, available_from, available_to) VALUES ('#{name}', '#{description}', '#{user_id}', '#{price}', '#{available_from}', '#{available_to}') RETURNING id, name, description, user_id, price, available_from, available_to;")[0]
      Space.new(id: result['id'], name: result['name'], description: result['description'], user_id: result['user_id'], price: result['price'], available_from: result['available_from'], available_to: result['available_to'])
    end

    def find(id:)
      connection = make_connection()
      result = connection.exec("SELECT * FROM spaces WHERE id = #{id};")[0]
      Space.new(id: result['id'], name: result['name'], description: result['description'], user_id: result['user_id'], price: result['price'], available_from: result['available_from'], available_to: result['available_to'])
    end

    def find_request(space_id:)
      connection = make_connection()
      results = connection.exec("SELECT spaces.id, spaces.name, spaces.description, spaces.user_id, spaces.price, spaces.available_from, spaces.available_to FROM spaces INNER JOIN bookings ON spaces.id = bookings.space_id WHERE spaces.id = '#{space_id}';")
      Space.new(id: results[0]['id'], name: results[0]['name'], description: results[0]['description'], user_id: results[0]['user_id'], price: results[0]['price'], available_from: results[0]['available_from'], available_to: results[0]['available_to'])
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
