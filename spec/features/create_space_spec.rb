feature 'Form page for creating new spaces' do
  scenario 'has the correct fields' do
    create_user()
    login_user()
    visit('/spaces/new')
    expect(page).to have_field "Name"
    expect(page).to have_field "Description"
    expect(page).to have_field "Price per night"
    expect(page).to have_button "Submit New Space"
    expect(page).to have_field "available_from"
    expect(page).to have_field "available_to"
  end

  scenario 'can create a space' do
    create_user()
    login_user()
    visit('/spaces/new')
    fill_in(:Name, with: "The moon")
    fill_in(:Description, with: "Lots of space, wonderful views, lots of peace and quiet, perfect for screaming without being heard!")
    fill_in("Price per night", with: "100000000")
    fill_in("available_from", with: "#{Date.today.strftime('%Y-%m-%d')}")
    fill_in("available_to", with: "#{(Date.today + 30).strftime('%Y-%m-%d')}")
    click_button "Submit New Space"
    expect(page).to have_content "The moon"
    expect(page).to have_content "Lots of space, wonderful views,"
    expect(page).to have_content "£100000000"
    expect(page).to have_content "#{Date.today.strftime('%Y-%m-%d')}"
    expect(page).to have_content "#{(Date.today + 30).strftime('%Y-%m-%d')}"
    expect(page).not_to have_content "Sinatra"
  end

  scenario 'user cannot create space without logging in' do
    visit("/spaces")
    expect(page).to have_content "Sign in or create account to list your space"
    expect(page).not_to have_button "Create Space"
  end

  scenario 'user cannot access create space page without logging in' do
    visit('/spaces/new')
    expect(page).to have_content "Please sign in to list your space"
  end


end
