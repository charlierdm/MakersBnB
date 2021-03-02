feature 'Form page for creating new spaces' do
  scenario 'has the correct fields' do
    visit('/spaces/new')
    expect(page).to have_field "Name"
    expect(page).to have_field "Description"
    expect(page).to have_field "Price per night"
    expect(page).to have_button "Submit New Space"
  end
end
