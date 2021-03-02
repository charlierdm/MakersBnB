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
    expect(page).to have_content "Thanks for registering with Hotel Rspectors, test_username"
    expect(page).to have_button 'Back to homepage'
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
