require './config/environment'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security_is_important"
  end

  get '/' do
    erb :home
  end

  get '/login' do
    erb :login
  end

  get '/signup' do
    erb :signup
  end

  get '/logout' do
    redirect '/'
  end

  post '/signup' do
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])
    @user.bio = params[:bio] if !params[:bio].empty?
    redirect "/users/#{@user.id}"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def curret_user
      session[:user_id] && User.find(session[:user_id])
    end
  end
end
