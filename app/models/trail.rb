class Trail < ActiveRecord::Base
  belongs_to :state
  has_many :user_trails
  has_many :users, through: :user_trails

  mattr_accessor :display_attributes

  validates :name, presence: true, uniqueness: true
  validates :length, numericality: true, allow_nil: true
  validates :difficulty, numericality: { only_integer: true, greater_than_or_eqaul_to: 0, less_than_or_eqaul_to: 10}, allow_nil: true
  validates :start_alt, numericality: true, allow_nil: true
  validates :end_alt, numericality: true, allow_nil: true

  validate :both_alts_present

  def both_alts_present
    errors.add(:alts, "must include both a starting and ending altitude") if end_alt && !start_alt || start_alt && !end_alt
  end

  before_save do
    self.slug = self.name.gsub(/[^a-zA-Z0-9]+/, "-").downcase
    self.slug.slice!(-1) if self.slug =~ /-\z/
  end

  self.display_attributes= %w(name length difficulty start_alt end_alt state)

  def display_self(**options)
    make_self_display() unless @display_self
    if options
      @display_self.map do |k, v|
        if options.keys.include?(k)
          v + " " + options[k]
        else
          v
        end
      end
    else
      @display_self.values.flatten
    end
  end

  def make_self_display()
    @display_self = {}
    self.class.display_attributes.map do |attribute|
      if self.send(attribute)
        @display_self[attribute.to_sym] = "#{attribute}: #{self.send(attribute)}"
      end
    end
    @display_self[:state] = @display_self[:state].slice(/(.+: )/) << "<a href=\"\/states\/#{self.state.code}\">#{self.state.name}</a>"
  end
end
