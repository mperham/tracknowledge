class RemoveHabtmIdColumn < ActiveRecord::Migration
  def self.up
    remove_column :track_categories, :id
    add_index :track_categories, :track_id
  end

  def self.down
    remove_index :track_categories, :track_id
    add_column :track_categories, :id, :integer
  end
end
