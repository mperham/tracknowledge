class AddTurnsAndWikipedia < ActiveRecord::Migration
  def self.up
    add_column :track_versions, :turns, :integer
    add_column :tracks, :turns, :integer
    add_column :track_versions, :wikipedia_url, :string, :limit => 128
    add_column :tracks, :wikipedia_url, :string, :limit => 128
  end

  def self.down
    remove_column :track_versions, :turns
    remove_column :tracks, :turns
    remove_column :track_versions, :wikipedia_url
    remove_column :tracks, :wikipedia_url
  end
end
