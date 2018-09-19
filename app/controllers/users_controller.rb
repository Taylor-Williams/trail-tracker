class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by(slug: params[:slug])
    if @user
      erb :"users/show"
    else
      redirect '/'
    end
  end

  post '/users/:user_id/:trail_id' do
    @user = User.find(params[:user_id])
    trail = Trail.find(params[:trail_id])
    if !@user.trail_ids.include?(trail.id)
      @user.user_trails.create(trail_id: trail.id)
    else
      UserTrail.find_by(trail_id: trail.id, user_id: @user.id).destroy
    end
    redirect "/users/#{@user.slug}"
  end

end
