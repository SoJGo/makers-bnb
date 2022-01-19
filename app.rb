require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space'
require './lib/bookings'
require './database_connection_setup'

class MakersBnB < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader
    also_reload './lib/space'
  end

  enable :sessions, :method_override

  get '/' do
    redirect '/spaces'
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

  post '/requests/:id' do
    @space_arr = Space.find(id: params[:id])
    @space = @space_arr[0]
    Bookings.create(booker_id: session[:user_id], space_id: @space.id, owner_id: @space.user_id, confirmed: false, date: params[:date])
    redirect '/requests'
  end

  run! if app_file == $0
end
