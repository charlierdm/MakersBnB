require 'pg'

class User
=begin
notes from 02/03/21. have just implemented name_exists?
and email_exists? methods, these prevent users from registering
with values that already exist. Next thing to do is use these
to create a login method.
=end
  attr_reader :id, :username, :email, :password

  def initialize(id:, username:, email:, password:)
    @id = id
    @username = username
    @email = email
    @password = password
  end

  def self.create(username:, email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    fail "username already taken" if name_exists?(username)
    fail "email already taken" if email_exists?(email)
    result = connection.exec("INSERT INTO users (username, email, password) VALUES('#{username}', '#{email}', '#{password}') RETURNING *;")
    User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'], password: result[0]['password'])
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec("SELECT * FROM users;")
    result.map do |user|
      User.new(id: user['id'], username: user['username'], email: user['email'], password: user['password'])
    end
  end

  private
  def self.name_exists?(username)
    users = User.all
    existing_names = []
    users.map do |user|
      existing_names << user.username
    end
    existing_names.include?(username) ? true : false
  end

  def self.email_exists?(username)
    users = User.all
    existing_emails = []
    users.map do |user|
      existing_emails << user.email
    end
    existing_emails.include?(username) ? true : false
  end

end
