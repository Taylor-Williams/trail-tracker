class User < ActiveRecord::Base
  has_secure_password
  has_many :user_trails
  has_many :trails, through: :user_trails
  has_many :states, through: :trails
end
