feature 'user wants to register' do
  scenario 'homepage has link to new registration form' do
    visit('/')
    expect(page).to have_button "Register here"
  end

  scenario 'user fills in form and registers' do
    visit('user/new')
    fill_in :username, with: "test_username"
    fill_in :email, with: "test@example.com"
    fill_in :password, with: 'letmein'
    click_button('Register')
    save_and_open_page
    expect(page).to have_content "Thanks for registering with Hotel Rspectors, test_username"
    expect(page).to have_button 'Back to homepage'
  end

  scenario 'username already taken' do
    #user registers
    visit('user/new')
    fill_in :username, with: "test_username"
    fill_in :email, with: "test@example.com"
    fill_in :password, with: 'letmein'
    click_button('Register')
    click_button('Back to homepage')
    #user tries to register with same username
    visit('user/new')
    save_and_open_page
    fill_in :username, with: "test_username"
    fill_in :email, with: "test2@example.com"
    fill_in :password, with: 'letmein'
    click_button('Register')
    save_and_open_page
    expect(page).not_to have_content 'RuntimeError'
    expect(page).to have_content 'username already taken'
  end

  scenario 'email already taken' do
    #user registers
    visit('user/new')
    fill_in :username, with: "test_username"
    fill_in :email, with: "test@example.com"
    fill_in :password, with: 'letmein'
    click_button('Register')
    click_button('Back to homepage')
    #user tries to register with same username
    visit('user/new')
    save_and_open_page
    fill_in :username, with: "test_username2"
    fill_in :email, with: "test@example.com"
    fill_in :password, with: 'letmein'
    click_button('Register')
    save_and_open_page
    expect(page).not_to have_content 'RuntimeError'
    expect(page).to have_content 'email already taken'
  end

end

feature 'Form page for creating new user' do
  scenario 'has the correct fields' do
    visit('/user/new')
    expect(page).to have_field "username"
    expect(page).to have_field "email"
    expect(page).to have_field "password"
  end
end
