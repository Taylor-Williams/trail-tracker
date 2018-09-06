class Trail < ActiveRecord::Base
  belongs_to :state
  has_many :user_trails
  has_many :users, through: :user_trails
end
