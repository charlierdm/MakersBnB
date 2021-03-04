require 'user'

describe User do

  describe '.create' do
    it 'creates a new user' do
      user = User.create(username: "test_user", email: "test@example.com", password: "letmein")[1]

      expect(user).to be_a(User)
      expect(user.username).to eq("test_user")
      expect(user.email).to eq("test@example.com")
      expect(user.password).to eq("letmein")
    end

    it "raises error if username is already taken " do
      User.create(username: "test_user", email: "test@example.com", password: "letmein")
      expect(User.create(username: "test_user", email: "test2@example.com", password: "letmein")).to eq([false, "username already taken"])
    end

    it "raises an error if the email is already taken " do
      User.create(username: "test_user", email: "test@example.com", password: "letmein")
      expect(User.create(username: "test_user2", email: "test@example.com", password: "letmein")).to eq([false, "email already taken"])
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

  describe '.login' do
    context 'is successful' do
      before(:each) do
        User.create(username: "test_user2", email: "test2@example.com", password: "letmein")
      end

      it 'returns user_id and username' do
        user = User.login(email: "test2@example.com", password: "letmein")
        expect(user.first).to eq true
        expect(user[1].username).to eq "test_user2"
        # expect(user[1].id).to eq 1
      end
    end

    context 'is unsuccessful' do
      before(:each) do
        User.create(username: "test_user2", email: "test2@example.com", password: "letmein")
      end

      it 'because email is wrong' do
        user = User.login(email: "test2electric_boogaloo@example.com", password: "letmein")
        expect(user.first).to eq false
        expect(user[1]).to include "email"
        expect(user[1]).not_to include "password"
      end

      it 'because password is wrong' do
        user = User.login(email: "test2@example.com", password: "letmein#vamp_lyfe")
        expect(user.first).to eq false
        expect(user[1]).not_to include "email"
        expect(user[1]).to include "password"
      end

    end
  end

end
