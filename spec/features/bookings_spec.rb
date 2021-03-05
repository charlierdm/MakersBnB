require 'pg'

feature 'confirmation of booking request' do
  scenario 'page displays that the request has been sent to the owner' do
    create_user()
    login_user()
    visit('/spaces/new')
    fill_in(:Name, with: "The moon")
    fill_in(:Description, with: "Lots of space, wonderful views, lots of peace and quiet, perfect for screaming without being heard!")
    fill_in("Price per night", with: "100000000")
    fill_in("available_from", with: "#{Date.today.strftime('%Y-%m-%d')}")
    fill_in("available_to", with: "#{(Date.today + 30).strftime('%Y-%m-%d')}")
    click_button "Submit New Space"
    visit(/spaces/)
  end
end



create_user()
login_user()
puts(current_url)
visit('/spaces/new')
puts(current_url)
fill_in "Name", with: "Test Space"
fill_in "Description", with: "The most beautiful test space you'll ever see"
fill_in "Price", with: 50
click_button "Submit New Space"
