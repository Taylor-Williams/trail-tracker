class StatesController < ApplicationController

  get '/states' do
    @states = State.all
    erb :'states/index'
  end

  get '/states/:code' do
    @state = State.find_by(code: params[:code])
    if @state
      erb :"states/show"
    else
      redirect '/states'
    end
  end
end
