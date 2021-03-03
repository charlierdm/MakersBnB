def create_space_test
  create_user()
  login_user()
  puts(current_url)
  visit('/spaces/new')
  puts(current_url)
  fill_in "Name", with: "Test Space"
  fill_in "Description", with: "The most beautiful test space you'll ever see"
  fill_in "Price", with: 50
  click_button "Submit New Space"
end

def create_user
  visit('user/new')
  fill_in :username, with: "test_username"
  fill_in :email, with: "test@example.com"
  fill_in :password, with: 'letmein'
  click_button('Register')
  visit('/')
end

def login_user
  visit('user/login')
  fill_in :email, with: "test@example.com"
  fill_in :password, with: 'letmein'
  click_button('Login')
end