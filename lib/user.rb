require 'pg'
require_relative 'sql_connections'

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

  class << self

    def create(username:, email:, password:)
      return [false, "username already taken"] if name_exists?(username)
      return [false, "email already taken"] if email_exists?(email)
      result = Connection.exec("INSERT INTO users (username, email, password) VALUES('#{username}', '#{email}', '#{password}') RETURNING *;")
      [true, User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'], password: result[0]['password'])]
    end

    def all
      result = Connection.exec("SELECT * FROM users;")
      result.map do |user|
        User.new(id: user['id'], username: user['username'], email: user['email'], password: user['password'])
      end
    end

    def login(email:, password:)
      return [false, "wrong email address"] if not email_exists?(email)
      return [false, "wrong password"] if not password_correct?(email: email, password: password)
      result = Connection.exec("SELECT * FROM users WHERE email = '#{email}';")
      [true, User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'], password: result[0]['password'])]
    end

    private

    def password_correct?(email:, password:)
      result = Connection.exec("SELECT * FROM users WHERE email='#{email}';")
      # return BCrypt::Password.new(result[0]['password']) == password
      result[0]['password'] == password
    end

    def name_exists?(username)
      users = User.all
      existing_names = []
      users.map do |user|
        existing_names << user.username
      end
      existing_names.include?(username) ? true : false
    end

    def email_exists?(username)
      users = User.all
      existing_emails = []
      users.map do |user|
        existing_emails << user.email
      end
      existing_emails.include?(username) ? true : false
    end

  end
end
