feature "header bar when user logged in" do
  before(:each) do
    log_in()
  end
  scenario "/spaces" do
    visit("/spaces")
    expect_logged_in("test_username")
  end

  scenario '/spaces/new' do
    visit("/spaces/new")
    expect_logged_in("test_username")
  end

  scenario '/user/new' do
    visit("/user/new")
    expect_logged_in("test_username")
  end

end

feature "header bar when user isn't logged in" do
  scenario "/spaces" do
    visit("/spaces")
    not_logged_in_test()
  end

  scenario '/spaces/new' do
    visit("/spaces/new")
    not_logged_in_test()
  end

  scenario '/user/new' do
    visit("/user/new")
    not_logged_in_test()
  end

end

def log_in()
  create_user()
  login_user()
end

def not_logged_in_test()
  expect_not_logged_in()
end


def expect_logged_in(username="test_username")
  expect(page).to have_content username
  expect(page).to have_link('Spaces', href: "/spaces")
  expect(page).to have_link('Requests', href: "/user/requests")
  expect(page).to have_link('Logout', href: "/user/logout")

  expect(page).not_to have_link('Create Account', href: "/user/new")
  expect(page).not_to have_link('Login', href: "/user/login")
end

def expect_not_logged_in()
  expect(page).to have_content "Login or Create Account to List and Book Spaces!"
  expect(page).not_to have_link('Spaces', href: "/spaces")
  expect(page).not_to have_link('Requests', href: "/user/requests")
  expect(page).not_to have_link('Logout', href: "/user/logout")

  expect(page).to have_link('Create Account', href: "/user/new")
  expect(page).to have_link('Login', href: "/user/login")
end