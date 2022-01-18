require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space'

class MakersBnB < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader
    also_reload './lib/space'
  end

  get '/' do
    'Hello!'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/index'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces/new' do
    Space.create(name: params[:space_name], description: params[:space_description], price: params[:space_price])
    redirect '/spaces'
  end

  run! if app_file == $0
end
