require 'sinatra/base'
require 'pg'
require './lib/space.rb'
require './lib/user.rb'
require './lib/booking.rb'


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
    @user_id = session[:user_id]
    puts "spaces session = #{session[:user_id]}"
    erb :'spaces/listings'
  end

  get '/spaces/new' do
    @user_id = session[:user_id]
    @user_id == nil ? @disabled = "disabled" : @disabled = nil
    # puts "user_ID: ", @user_id
    erb :'spaces/create_space_form'
  end

  post '/create_space' do
    Space.create(name: params[:Name], description: params[:Description], user_id: session[:user_id] , price: params[:Price], available_from: params[:available_from], available_to: params[:available_to])
    redirect '/spaces'
  end

  get '/spaces/space/:id' do
    @space = Space.find(id: params[:id])
    session['id'] = params[:id]
    @user_id = session[:user_id]
    erb :'spaces/space'
  end

  post '/bookings/create_booking' do
    booking = Booking.create(space_id: session['id'], user_id: session['user_id'], date: params[:choose_date], booking_status: "pending", available: "1")
    p booking
    redirect '/bookings/confirmation'
  end

  get '/bookings/confirmation' do
    erb :'bookings/confirmation'
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
      # p "login attempt visibility"
      # p user
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
