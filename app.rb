require 'sinatra/base'
require 'pg'

class Hotel < Sinatra::Base
enable :sessions, :method_override

  get '/' do
    erb :index
  end

  #users
  # there will be a link on the home page for 'register as a new user'.
  # this link will take you to a new page to input your details.
  # create a user class that accesses the details, saves them to database.
  # you can now log in and out as user.

  # future work - how to relate space to owner (user_id).
  # requesting to book, and confirmation, need to wait until spaces and users are linked.


  get '/spaces' do
    # collect Space.self.all from space.rb (from spaces table in database)
    # render this in below erb view
    # don't worry about setting availability just yet.
    # the developer 'user' can add loads of spaces, and view them all on this page.
    # setting availability for a space.
    erb :'spaces/listings'
  end

  get '/spaces/new' do
    erb :'spaces/create_space_form'
  end

  post '/create_space' do
    # collect new space info into database
    # Space.create(name: params[], description, user, price)
    # as part of this, space.self.all, space.self.create need to be made.
    redirect '/spaces'
  end
end
