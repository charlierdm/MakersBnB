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
  end

  

end
