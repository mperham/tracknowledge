class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name, :null => false, :limit => 32
    end
    
    create_table :track_categories do |t|
      t.integer :category_id, :null => false
      t.integer :track_id, :null => false
    end
  end

  def self.down
    drop_table :categories
    drop_table :track_categories
  end
end
