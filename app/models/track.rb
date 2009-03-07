require 'state_helper'

class Track < ActiveRecord::Base
  acts_as_mappable
  acts_as_versioned
  xss_terminate
  
  # This blob should never be accessed directly.  Use #details instead
  # which will dynamically create the blob if necessary.
  belongs_to :track_blob
  has_and_belongs_to_many :categories, :join_table => 'track_categories'
  
  validates_presence_of :name, :lng, :lat, :country_code, :user_email
  validates_presence_of :state, :message => 'is required for tracks in the USA', :if => Proc.new { |track| track.country_code == 'usa' }
  validates_format_of :user_email, :with => /^[a-zA-Z0-9_+\.]+@([a-zA-Z0-9\-]+)(\.[a-zA-Z0-9\-]+)+$/
  validates_format_of :country_code, :with => /\A[a-z]{3}\Z/
  validates_format_of :website, :message => 'must be a full URL, starting with http://', :if => Proc.new { |track| !track.website.blank? }, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_format_of :wikipedia_url, :message => 'must be a Wikipedia link, starting with http://en.wikipedia.org/wiki/', :if => Proc.new { |track| !track.wikipedia_url.blank? }, :with => /^http:\/\/en\.wikipedia\.org\/wiki\/.+$/ix
  validates_uniqueness_of :wikipedia_url, :message => ' already exists.  This indicates this track has already been entered into our database.', :if => Proc.new { |track| !track.wikipedia_url.blank? }
  validates_numericality_of :lat, :greater_than => -90, :less_than => 90
  validates_numericality_of :lng, :greater_than => -180, :less_than => 180
  validates_numericality_of :turns, :allow_nil => true, :only_integer => true, :greater_than => 0, :less_than => 1_000
  validates_numericality_of :capacity, :allow_nil => true, :only_integer => true, :greater_than => 0, :less_than => 1_000_000
  validates_numericality_of :year_built, :allow_nil => true, :only_integer => true, :greater_than => 1900, :less_than => 2020
  validates_numericality_of :length_in_km, :allow_nil => true, :greater_than => 0, :less_than => 50
  
  before_create :add_empty_blob
  
  def country
    country_lookup(self.country_code)
  end
  
  def distance
    # (ACOS(least(1,COS(#{lat})*COS(#{lng})*COS(RADIANS(#{qualified_lat_column_name}))*COS(RADIANS(#{qualified_lng_column_name}))+
    #                   COS(#{lat})*SIN(#{lng})*COS(RADIANS(#{qualified_lat_column_name}))*SIN(RADIANS(#{qualified_lng_column_name}))+
    #                   SIN(#{lat})*SIN(RADIANS(#{qualified_lat_column_name}))))*#{multiplier})  end
    
    100
  end

  def state_name
    self.state.blank? ? nil : state_lookup(self.state)
  end
  
  def notes
    details.notes
  end
  
  def notes=(text)
    details.notes = text
  end
  
  def approved?
    status == 1
  end
  
  def approve!
    self.status = 1
    save!
  end
  
  def tags
    @tags ||= details.tags.split(' ')
  end
  
  def tags=(text)
    details.tags = text
    @tags = nil
  end
  
  def details
    self.track_blob ||= TrackBlob.new(:tags => '', :notes => '')
  end
  
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  private
  
  def add_empty_blob
    self.track_blob ||= TrackBlob.create!(:tags => '', :notes => '')
  end
  
  def country_lookup(code)
    code == 'usa' ? 'USA' : CountryCodes.find_by_a3(code)[:name]
  end

  def state_lookup(code)
    STATE_LOOKUP[code]
  end
end
