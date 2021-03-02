def create_space_test
  visit('/spaces/new')
  fill_in "Name", with: "Test Space"
  fill_in "Description", with: "The most beautiful test space you'll ever see"
  fill_in "Price", with: 50
  click_button "Submit New Space"
end
