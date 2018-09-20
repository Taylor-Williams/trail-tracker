require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security_is_important"
  end
  use Rack::Flash

  get '/' do
    if !logged_in?
      erb :home
    else
      redirect "/users/#{current_user.slug}"
    end
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect "/users/#{current_user.slug}"
    end
  end

  get '/signup' do
    erb :signup
  end

  get '/logout' do
    if logged_in?
      session.delete(:user_id)
    end
    redirect '/'
  end

  post '/signup' do
    @user = User.create(username: params[:username], password: params[:password], email: params[:email], bio: params[:bio])
    if !@user.valid?
      flash[:error] = @user.errors.messages.map do |k,v|
        "<p>there was an issue with your #{k}: #{v.join(", ")}</p>"
      end.join
      redirect '/signup'
    else
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    end
  end

  post '/login' do
    if !params[:username].empty? && !params[:password].empty?
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/users/#{user.slug}"
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      session[:user_id] && User.find(session[:user_id])
    end
  end
end
