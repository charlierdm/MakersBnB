feature 'blablabla' do
  scenario 'whatever' do
    visit('/')
    expect(page).to have_content "Welcome to Hotel Rspectors"
    expect(page).to have_button "Listings"
  end
end
