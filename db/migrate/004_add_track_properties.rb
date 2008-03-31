class AddTrackProperties < ActiveRecord::Migration
  def self.up
    add_column :tracks, :year_built, :integer
    add_column :tracks, :designer, :string, :limit => 64
    add_column :tracks, :length_in_km, :float
    add_column :tracks, :address, :string, :limit => 128
    add_column :tracks, :website, :string, :limit => 128
    Track.create_versioned_table
  end

  def self.down
    remove_column :tracks, :year_built
    remove_column :tracks, :designer
    remove_column :tracks, :length_in_km
    remove_column :tracks, :address
    remove_column :tracks, :website
    Track.drop_versioned_table
  end
end
