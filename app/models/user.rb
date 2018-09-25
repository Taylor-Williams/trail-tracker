class User < ActiveRecord::Base
  has_many :user_trails
  has_many :trails, through: :user_trails
  has_many :states, through: :trails

  validates :username, length: { in: 5..18 }, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  before_save do
    self.slug = self.username.gsub(/[^a-zA-Z0-9]+/, "-").downcase
    self.slug.slice!(-1) if self.slug =~ /-\z/
  end
end
