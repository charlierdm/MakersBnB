
feature "Requests Page:" do
  scenario "has the user specific booking requests" do
    @user = User.create(username: 'test_username', email: 'email@email.com', password: 'password')
    @space = Space.create(name: 'test_name', description: 'test_description', user_id: @user[1].id, price: 100, available_from: "2021-1-5", available_to: "2021-10-3" )
    @booking = Booking.create(space_id: @space.id, date: "2021-03-03", user_id: @user[1].id, booking_status: "pending", available: "1")
    visit '/'
    click_button 'Login'
    fill_in :email, with: @user[1].email
    fill_in :password, with: @user[1].password
    click_button ('Login')
    visit '/user/requests'

    expect(page).to have_content("#{@space.name}")
    expect(page).to have_content("#{@booking.booking_status}")
  end

  scenario "user_1 books a request, sees it on their Requests page" do
    @user_1 = User.create(username: "test_username_1", email: "email_1@email.com", password: 'password')
    @space = Space.create(name: "test_name_1", description: 'test_description', user_id: @user_1[1].id, price: 100, available_from: "2021-1-5", available_to: "2021-10-3")

    @user_2 = User.create(username: "test_username_2", email: "email_2@email.com", password: 'password')
    @booking = Booking.create(space_id: @space.id, date: "2021-03-03", user_id: @user_2[1].id, booking_status: "pending", available: "1")

    visit '/'
    click_button 'Login'
    fill_in :email, with: @user_2[1].email
    fill_in :password, with: @user_2[1].password
    click_button ('Login')
    visit '/user/requests'
    expect(page).to have_content("#{@space.name}")
    expect(page).to have_content("#{@booking.booking_status}")
  end

  scenario "user_1 books a request, user_2 books user_1s space, user_1 sees both on their Requests page"

end

def create_users(i=3)
  (0..i).each do |i|
    @user = User.create(username: "test_username_#{i}", email: "email_#{i}@email.com", password: 'password')
    @space = Space.create(name: "test_name_#{i}", description: 'test_description', user_id: @user[1].id, price: 100 )
  end
end
