class Category < ActiveRecord::Base
  has_and_belongs_to_many :tracks, :join_table => 'track_categories'
end