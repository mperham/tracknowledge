class Category < ActiveRecord::Base
  has_many :track_categories, :dependent => :destroy
  has_many :tracks, :through => :track_categories
end