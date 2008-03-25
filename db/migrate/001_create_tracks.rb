class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string 		:name, :limit => 64, :null => false, :unique => true
      t.string 		:owner, :limit => 128
      t.string 		:country_code, :limit => 3, :null => false
      t.float     :longitude
      t.float     :latitude
      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end 
