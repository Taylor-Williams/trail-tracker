class State < ActiveRecord::Base
  has_many :trails
  has_many :users, through: :trails
end
