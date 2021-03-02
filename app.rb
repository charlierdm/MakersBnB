require 'sinatra/base'
require 'pg'

class Hotel < Sinatra::Base
enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/listings' do
    erb :listings
  end
end
