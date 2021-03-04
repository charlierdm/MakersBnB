feature "login from home page:" do

  scenario " homepage has login link" do
    visit '/'
    expect(page).to have_button('Login')
  end

  scenario "login button take you to login page" do
    visit '/'
    click_button('Login')
    expect(page).to have_current_path('/user/login')
  end

  scenario "has the email and password fields " do
    visit('/user/login')
    expect(page).to have_field "email"
    expect(page).to have_field "password"
    expect(page).to have_button("Login")
  end

  scenario "successful login" do
    create_user
    visit('/user/login')
    fill_in :email, with: 'test@example.com'
    fill_in :password, with: 'letmein'
    click_button('Login')
    # expect(page).to have_current_path('/')
    expect(page).to have_content('Welcome: test_username')
  end

  scenario "unsussessful email when loging in " do
    create_user
    visit('/user/login')
    fill_in :email, with: 'testwrong@example.com'
    fill_in :password, with: 'letmein'
    click_button('Login')
    expect(page).not_to have_content('Sinatra')
    expect(page).to have_content('wrong email address')
  end

  scenario "unsussessful password when loging in " do
    create_user
    visit('/user/login')
    fill_in :email, with: 'test@example.com'
    fill_in :password, with: 'dontletmein'
    click_button('Login')
    expect(page).not_to have_content('Sinatra')
    expect(page).to have_content('wrong password')
  end

end
