
def add_to_spaces(dbname = 'makersbnb_test')

  space_list = [{name: 'Schrute Farms', description: 'Despite what a Mr. Gareth Keenan may have indicated in his review, Schrute Farms is a safe destination for all travelers!', user_id: 1234, price: '57'}]

  connection = PG.connect(dbname: dbname)
  space_list.each do |space|
    result = connection.exec("INSERT INTO spaces (name, description, user_id, price) VALUES ('#{space[:name]}', '#{space[:description]}', '#{space[:user_id]}', '#{space[:price]}');")
  end
end