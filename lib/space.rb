require 'pg'

class Space

  attr_reader :id, :name, :description, :user_id, :price

  def initialize(id:, name:, description:, user_id:, price:)
    @id = id
    @name = name
    @description = description
    @user_id = user_id
    @price = price
  end


  class << self

    def all # identical to self.all
      connection = make_connection()
      result = connection.exec("SELECT * FROM spaces;")
      result.map do |space|
        Space.new(id: space['id'], name: space['name'], description: space['description'], user_id: space['user_id'], price: space['price'])
      end
    end

    def create(name:, description:, user_id:, price:, available_from:, available_to:)
      connection = make_connection()
      result = connection.exec("INSERT INTO spaces (name, description, user_id, price) VALUES ('#{name}', '#{description}', '#{user_id}', '#{price}') RETURNING id, name, description, user_id, price;")[0]
      Space.new(id: result['id'], name: result['name'], description: result['description'], user_id: result['user_id'], price: result['price'])
    end

    def find(id:)
      connection = make_connection()
      result = connection.exec("SELECT * FROM spaces WHERE id = #{id};")[0]
      Space.new(id: result['id'], name: result['name'], description: result['description'], user_id: result['user_id'], price: result['price'])
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
