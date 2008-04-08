class AddCapacity < ActiveRecord::Migration
  def self.up
    add_column :track_versions, :capacity, :integer
    add_column :tracks, :capacity, :integer
  end

  def self.down
    remove_column :track_versions, :capacity
    remove_column :tracks, :capacity
  end
end
