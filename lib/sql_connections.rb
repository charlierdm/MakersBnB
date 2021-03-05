require 'pg'

class Connection
  class << self

    def exec(query)
      connection = make_connection()
      result = connection.exec(query)
      connection.close()
      return result
    end

    def make_connection
      if ENV['ENVIRONMENT'] == 'test'
        return PG.connect(dbname: 'makersbnb_test')
      else
        return PG.connect(dbname: 'makersbnb')
      end
    end
  end
end