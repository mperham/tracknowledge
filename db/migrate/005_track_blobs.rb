class TrackBlobs < ActiveRecord::Migration
  def self.up
    create_table :track_blobs do |t|
      t.text :notes, :null => false
      t.text :tags, :null => false
    end
  end

  def self.down
    drop_table :track_blobs
  end
end
