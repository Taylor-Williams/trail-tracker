require './config/environment'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security_is_important"
  end
end
