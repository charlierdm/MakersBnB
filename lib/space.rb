require 'pg'
require_relative 'sql_connections'

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
      result = Connection.exec("SELECT * FROM spaces;")
      result.map do |space|
        Space.new(id: space['id'], name: space['name'], description: space['description'], user_id: space['user_id'], price: space['price'], available_from: space['available_from'], available_to: space['available_to'])
      end
    end

    def create(name:, description:, user_id:, price:, available_from:, available_to:)
      result = Connection.exec("INSERT INTO spaces (name, description, user_id, price, available_from, available_to) VALUES ('#{name}', '#{description}', '#{user_id}', '#{price}', '#{available_from}', '#{available_to}') RETURNING id, name, description, user_id, price, available_from, available_to;")[0]

      Space.new(id: result['id'], name: result['name'], description: result['description'], user_id: result['user_id'], price: result['price'], available_from: result['available_from'], available_to: result['available_to'])
    end

    def find(id:)
      result = Connection.exec("SELECT * FROM spaces WHERE id = #{id};")[0]
      Space.new(id: result['id'], name: result['name'], description: result['description'], user_id: result['user_id'], price: result['price'], available_from: result['available_from'], available_to: result['available_to'])
    end

  end
end
