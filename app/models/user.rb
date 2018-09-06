class User < ActiveRecord::Base

  validates :username, length: { in: 5..18 }, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  has_many :user_trails
  has_many :trails, through: :user_trails
  has_many :states, through: :trails
end
