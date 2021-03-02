require 'sinatra/base'
require 'pg'

class Hotel < Sinatra::Base
enable :sessions, :method_override

  get '/' do

  end

end
