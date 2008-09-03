class RemoveTextFromBlob < ActiveRecord::Migration
  def self.up
    change_table :track_blobs do |t|
      t.remove :text
    end
  end

  def self.down
  end
end
