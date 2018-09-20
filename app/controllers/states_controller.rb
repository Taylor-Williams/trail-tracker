class StatesController < ApplicationController

  get '/states' do
    @states = Trail.select(:state_id).where('state_id != ?', "").distinct.map{|s| State.find(s.state_id)}
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
