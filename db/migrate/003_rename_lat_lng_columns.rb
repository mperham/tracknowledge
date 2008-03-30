class RenameLatLngColumns < ActiveRecord::Migration
  def self.up
    rename_column :tracks, :latitude, :lat
    rename_column :tracks, :longitude, :lng
    add_column :users, :lat, :float
    add_column :users, :lng, :float
  end

  def self.down
    rename_column :tracks, :lat, :latitude
    rename_column :tracks, :lng, :longitude
    remove_column :users, :lat
    remove_column :users, :lng
  end
end
