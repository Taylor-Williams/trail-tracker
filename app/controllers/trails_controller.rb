class TrailsController < ApplicationController

  get '/trails' do
    @trails = Trail.all
    erb :"trails/index"
  end

  post '/trails' do
    @trail = Trail.new(name: params[:name])
    trail_attrs = %i(length difficulty start_alt end_alt)
    trail_attrs.each do |attribute|
      if !params[attribute].empty?
        @trail.send("#{attribute}=", params[attribute])
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


end
