require 'sinatra/base'
require 'pg'

class Hotel < Sinatra::Base
enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/spaces' do
    erb :'spaces/listings'
  end

  get '/spaces/new' do
    erb :'spaces/create_space_form'
  end

  post '/create_space' do
    #collect new space info into database

    redirect '/spaces'
  end
end
