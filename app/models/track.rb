class Track < ActiveRecord::Base
  acts_as_mappable
  acts_as_versioned
end
