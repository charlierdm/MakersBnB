def setup_test_database
  p "Setting up test database..."
  connection = PG.connect(dbname: "makersbnb_test")
  connection.exec("TRUNCATE bookings, spaces;")
end