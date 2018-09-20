class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by(slug: params[:slug])
    @trails = Trail.where("creator_id = ?", @user.id)
    if @user
      erb :"users/show"
    else
      redirect '/'
    end
  end

  post '/users/:slug/edit' do
    @user = User.find_by(slug: params[:slug])
    @user.update(bio: params[:bio])
    redirect "/users/#{@user.slug}"
  end

  post '/users/:user_id/:trail_id' do
    user = User.find(params[:user_id])
    @trail = Trail.find(params[:trail_id])
    if !user.trail_ids.include?(@trail.id)
      user.user_trails.create(trail_id: @trail.id)
    else
      UserTrail.find_by(trail_id: @trail.id, user_id: user.id).destroy
    end
    redirect "/trails/#{@trail.slug}"
  end

end
