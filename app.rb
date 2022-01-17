require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnB < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader
  end

  get '/' do
    'Hello!'
  end

  get '/spaces' do
    erb :'spaces/index'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  run! if app_file == $0
end
