class Track < ActiveRecord::Base
  acts_as_mappable
  acts_as_versioned
  
  # This blob should never be accessed directly.  Use #details instead
  # which will dynamically create the blob if necessary.
  belongs_to :track_blob
  has_and_belongs_to_many :categories, :join_table => 'track_categories'
  
  validates_presence_of :name, :owner, :address, :lng, :lat, :country_code
  validates_format_of :country_code, :with => /\A[a-z]{3}\Z/
  validates_numericality_of :lat, :greater_than => -90, :less_than => 90
  validates_numericality_of :lng, :greater_than => -180, :less_than => 180
  validates_numericality_of :year_built, :allow_nil => true, :only_integer => true, :greater_than => 1900, :less_than => 2020
  validates_numericality_of :length_in_km, :allow_nil => true, :greater_than => 0, :less_than => 30
  
  before_create :add_empty_blob
  
  def country
    country_lookup(self.country_code)
  end
  
  def notes
    details.notes
  end
  
  def tags
    @tags ||= details.tags.split(' ')
  end
  
  def details
    unless self.track_blob
      self.track_blob = TrackBlob.create!(:tags => '', :notes => '')
      self.save!
    end
    self.track_blob
  end
  
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  private
  
  def add_empty_blob
    self.track_blob = TrackBlob.create!(:tags => '', :notes => '')
  end
  
  def country_lookup(code)
    code == 'usa' ? 'USA' : CountryCodes.find_by_a3(code)[:name]
  end
end
