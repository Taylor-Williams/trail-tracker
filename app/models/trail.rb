class Trail < ActiveRecord::Base
  belongs_to :state
  has_many :user_trails
  has_many :users, through: :user_trails

  validates :name, presence: true, uniqueness: true
  validates :length, numericality: true
  validates :difficulty, numericality: { only_integer: true, greater_than_or_eqaul_to: 0, less_than_or_eqaul_to: 10}
  validates :start_alt, numericality: true
  validates :end_alt, numericality: true

  before_save do
    self.slug = self.username.gsub(/[^a-zA-Z0-9]+/, "-").downcase
    self.slug.slice![-2] if self.slug =~ /-\z/
    validates :slug, presence: true, uniqueness: true
    validates :end_alt, presence: true if self.start_alt?
    validates :start_alt, presence: true if self.end_alt?
  end
end
