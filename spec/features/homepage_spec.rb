  feature 'homepage' do
    scenario 'has standard homepage content' do
      visit('/')
      expect(page).to have_content "Welcome to Hotel Rspectors"
      expect(page).to have_button "Spaces"
    end


    scenario "has requests & confirmations button when logged in" do
      create_user()
      login_user()
      expect(page).to have_button("Requests")
    end

  end
