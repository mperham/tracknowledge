class TrackCategory < ActiveRecord::Base
  belongs_to :track
  belongs_to :category
end