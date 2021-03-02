require 'user'

describe User do

  describe '.create' do
    it 'creates a new user' do
      user = User.create(username: "test_user", email: "test@example.com", password: "letmein")

      expect(user).to be_a(User)
      expect(user.username).to eq("test_user")
      expect(user.email).to eq("test@example.com")
      expect(user.password).to eq("letmein")
    end
    it "raises error if username is already taken " do
      User.create(username: "test_user", email: "test@example.com", password: "letmein")
      expect { User.create(username: "test_user", email: "test2@example.com", password: "letmein") }.to raise_error("username already taken")
    end
    it "raises an error if the email is already taken " do
      User.create(username: "test_user", email: "test@example.com", password: "letmein"
      expect { User.create(username: "test_user2", email: "test@example.com", password: "letmein") }.to raise_error("email is already taken")
    end
  end

  describe '.all' do
    it 'returns a list of users' do
      User.create(username: "test_user", email: "test@example.com", password: "letmein")
      User.create(username: "test_user2", email: "test2@example.com", password: "letmein")

      users = User.all
      p users
      expect(users.length).to eq(2)
      expect(users[0].username).to eq("test_user")
      expect(users[1].username).to eq("test_user2")
      expect(users[0].email).to eq("test@example.com")
      expect(users[1].email).to eq("test2@example.com")

    end
  end


end
