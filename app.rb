require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './lib/space'
require './lib/bookings'
require './lib/user'
require './database_connection_setup'

class MakersBnB < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader
    also_reload './lib/space'
    also_reload './lib/user'
  end

  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    session[:user_id] ? erb(:spaces) : erb(:index)
  end

  get '/spaces' do
    @user = User.find(id: session[:user_id])
    @spaces = Space.all
    erb :'spaces/index'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces/new' do
    Space.create(name: params[:space_name], description: params[:space_description], 
    price: params[:space_price], user_id: session[:user_id])
    redirect '/spaces'
  end

  get '/spaces/:id' do
    @space_id = params[:id]
    @space = Space.find(id: @space_id)
    @user = User.find(id: session[:user_id])
    erb :'spaces/:id'
  end

  post '/requests/:id' do
    @space = Space.find(id: params[:id])
    Bookings.create(booker_id: session[:user_id], space_id: @space.id, space_name: @space.name, owner_id: @space.user_id, confirmed: false, date: params[:date])
    redirect '/requests'
  end

  get '/requests' do
    @requests_from_user = Bookings.from_user(user_id: session[:user_id])
    @requests_to_user = Bookings.to_user(user_id: session[:user_id])
    erb :'requests/index'
  end

  get '/requests/:id' do
    # @request = Bookings.find(id: params[:id])
    # @space = Space.find(id: @request.space_id)
    erb :'requests/:id'
  end

  post '/users' do
    user = User.create(
      name: params[:name], username: params[:username], 
      email: params[:email], password: params[:password]
    )
    session[:user_id] = user.id
    redirect '/spaces'
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])

    if user
      session[:user_id] = user.id
      redirect '/spaces'
    else
      flash[:notice] = "Something wasn't right! Try again..."
      redirect '/sessions/new' 
    end
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'Bye for now. Come back soon!'
    redirect '/'
  end

  run! if app_file == $0
end
