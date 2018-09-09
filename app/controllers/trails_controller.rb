class TrailsController < ApplicationController

  get '/trails' do
    @trails = Trail.all
    erb :"trails/index"
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
