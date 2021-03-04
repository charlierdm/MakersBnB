
feature "Requests Page:" do
  scenario "has the user specific booking requests" do
    @user = User.create(username: 'test_username', email: 'email@email.com', password: 'password')
    @space = Space.create(name: 'test_name', description: 'test_description', user_id: @user[1].id, price: 100 )
    @booking = Booking.create(space_id: @space.id, date: "2021-03-03", user_id: @user[1].id, booking_status: "pending", available: "1")
    @booking2 = Booking.create(space_id: @space.id, date: "2021-03-05", user_id: @user[1].id, booking_status: "pending", available: "1")
    visit '/'
    click_button 'Login'
    fill_in :email, with: @user[1].email
    fill_in :password, with: @user[1].password
    click_button ('Login')
    visit '/user/requests'
    save_and_open_page
    expect(page).to have_content("#{@space.name}")
    expect(page).to have_content("#{@booking.booking_status}")
  end
end
