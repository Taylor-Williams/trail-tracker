class State < ActiveRecord::Base
  has_many :trails
  has_many :users, through: :trails

  validates :name, presence: true
  validates :code, presence: true, length: { is: 2 }
end
