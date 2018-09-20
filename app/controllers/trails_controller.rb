class TrailsController < ApplicationController

  get '/trails' do
    if logged_in?
      @trails = Trail.all
      erb :"trails/index"
    else
      redirect '/login'
    end
  end

  post '/trails' do
    @trail = Trail.new
    trail_attrs = %i(name length difficulty start_alt end_alt)
    trail_attrs.each do |attribute|
      if !params[attribute].empty?
        @trail.send("#{attribute}=", params[attribute])
      end
    end
    if !params[:state].empty?
        if params[:state].length == 2
          state = State.where('lower(code) = ?', params[:state].downcase).first
        else
          state = State.where('lower(name) = ?', params[:state].downcase).first
        end
        if state
          @trail.state = state
        end
    end
    @trail.creator_id = current_user.id
    @trail.save
    if !@trail.valid?
      flash[:error] = @trail.errors.messages.map do |k,v|
        "<p>there was an issue with your #{k}: #{v.join(", ")}</p>"
      end.join
      redirect '/trails/new'
    else
      if params[:user_id]
        @trail.user_trails.create(user_id: params[:user_id])
      end
      redirect "/trails/#{@trail.slug}"
    end
  end

  get '/trails/new' do
    if logged_in?
      erb :"/trails/new"
    else
      redirect "/login"
    end
  end

  get '/trails/:slug' do
    if logged_in?
      @trail = Trail.find_by(slug: params[:slug])
      if @trail
        erb :"trails/show"
      else
        redirect '/trails'
      end
    else
      redirect "/login"
    end
  end

  post '/trails/:slug/edit' do
    @trail = Trail.find_by(slug: params[:slug])
    trail_attrs = %i(name length difficulty start_alt end_alt)
    trail_attrs.each do |attribute|
      if !params[attribute].empty?
        @trail.send("#{attribute}=", params[attribute])
      end
    end
    if !params[:state].empty?
        if params[:state].length == 2
          state = State.where('lower(code) = ?', params[:state].downcase).first
        else
          state = State.where('lower(name) = ?', params[:state].downcase).first
        end
        if state
          @trail.state = state
        end
    end
    @trail.save
    if !@trail.valid?
      flash[:error] = @trail.errors.messages.map do |k,v|
        "<p>there was an issue with your #{k}: #{v.join(", ")}</p>"
      end.join
    else
      if params[:user_id] && !@trail.user_ids.include?(:user_id)
        @trail.user_trails.create(user_id: params[:user_id])
      elsif !params[:user_id] && @trail.user_ids.include?(current_user.id)
        UserTrail.find_by(trail_id: @trail.id, user_id: current_user.id).destroy
      end
    end
    redirect "/trails/#{@trail.slug}"
  end

  post '/trails/:slug/destroy' do
    Trail.find_by(slug: params[:slug]).destroy
    redirect '/trails'
  end
end
