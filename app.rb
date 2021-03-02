require 'sinatra/base'
require 'pg'
require './lib/space.rb'

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
    @all_spaces = Space.all
    puts @all
    erb :'spaces/listings'
  end

  get '/spaces/new' do
    erb :'spaces/create_space_form'
  end

  post '/create_space' do
    session['user_id'] = 1234
    Space.create(name: params[:Name], description: params[:Description], user_id: session['user_id'] , price: params[:Price])
    redirect '/spaces'
  end

  get '/user/new' do
    # link to take user to the registration page user/create_user
    erb :'user/create_user_form'
  end

  post '/user/create_user' do
    newuser = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:username] = newuser.username
    redirect '/user/confirmation'
  end

  get '/user/confirmation' do
    # display confirmation of registration
    @username = session[:username]
    erb :'user/confirmation'
  end




end
