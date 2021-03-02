feature 'Listings page' do
  scenario 'should display a new space' do
    create_space_test
    expect(page).to have_content "Test Space"
    expect(page).to have_content "The most beautiful test space you'll ever see"
    expect(page).to have_content 50
  end

end
