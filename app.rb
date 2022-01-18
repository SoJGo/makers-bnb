require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space'
require './database_connection_setup'

class MakersBnB < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader
    also_reload './lib/space'
  end

  enable :sessions, :method_override

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

  get '/spaces/:id' do
    @space_id = params[:id]
    @space_arr = Space.find(id: @space_id)
    @space = @space_arr[0]
    erb :'spaces/:id'
  end

  run! if app_file == $0
end
