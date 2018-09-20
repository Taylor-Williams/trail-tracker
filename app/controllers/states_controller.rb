class StatesController < ApplicationController

  get '/states' do
    if logged_in?
      @states = Trail.select(:state_id).where('state_id != ?', "").distinct.map{|s| State.find(s.state_id)}
      erb :'states/index'
    else
      redirect '/login'
    end
  end

  get '/states/:code' do
    if logged_in?
      @state = State.find_by(code: params[:code])
      if @state
        erb :"states/show"
      else
        redirect '/states'
      end
    else
      redirect '/login'
    end
  end
end
