require 'sinatra/base'
require 'pg'
require './lib/space.rb'
require './lib/user.rb'


class Hotel < Sinatra::Base
enable :sessions, :method_override

  get '/' do
    @user_id = session[:user_id]
    @username = session[:username]
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
    @params = params
    # link to take user to the registration page user/create_user
    erb :'user/create_user_form'
  end

  post '/user/create_user' do
    newuser = User.create(username: params[:username], email: params[:email], password: params[:password])
    if newuser[0] == true
      session[:username] = newuser[1].username
      redirect '/user/confirmation'
    else
      redirect "user/new?error=#{newuser[1]}"
    end
  end

  get '/user/confirmation' do
    # display confirmation of registration
    @username = session[:username]
    erb :'user/confirmation'
  end

  get '/user/login' do
    @params = params
    erb :'user/login'
  end

  post '/user/login_attempt' do
    user = User.login(email: params[:email], password: params[:password])
    if user[0] == true
      p "login attempt visibility"
      p user
      session[:user_id] = user[1].id
      session[:username] = user[1].username
      redirect '/'
    else
      redirect "user/login?error=#{user[1]}"
    end
  end

  get '/user/logout' do
    session[:user_id] = nil
    session[:username] = nil
    redirect '/'
  end

end
