class Track < ActiveRecord::Base
  acts_as_mappable
  acts_as_versioned
  
  validates_format_of :country_code, :with => /\A[a-z]{2}\Z/
  validates_numericality_of :lat, :greater_than => -90, :less_than => 90
  validates_numericality_of :lng, :greater_than => -180, :less_than => 180
  validates_numericality_of :year_built, :allow_nil => true, :only_integer => true, :greater_than => 1900, :less_than => 2020
  validates_numericality_of :length_in_km, :allow_nil => true, :greater_than => 0, :less_than => 30
end
