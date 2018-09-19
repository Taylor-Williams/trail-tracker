class TrailsController < ApplicationController

  get '/trails' do
    @trails = Trail.all
    erb :"trails/index"
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
    @trail.save
    if !@trail.valid?
      @errors = @trail.errors.messages
      erb :errors
    else
      if params[:user_id]
        @trail.user_trails.create(user_id: params[:user_id])
      end
      redirect "/trails/#{@trail.slug}"
    end
  end

  get '/trails/new' do
    erb :"/trails/new"
  end

  get '/trails/:slug' do
    @trail = Trail.find_by(slug: params[:slug])
    if @trail
      erb :"trails/show"
    else
      redirect '/trails'
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
      @errors = @trail.errors.messages
      erb :errors
    else
      if params[:user_id] && !@trail.user_ids.include?(:user_id)
        @trail.user_trails.create(user_id: params[:user_id])
      elsif !params[:user_id] && @trail.user_ids.include?(current_user.id)
        UserTrail.find_by(trail_id: @trail.id, user_id: current_user.id).destroy
      end
      redirect "/trails/#{@trail.slug}"
    end
  end



end
