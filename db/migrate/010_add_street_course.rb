class AddStreetCourse < ActiveRecord::Migration
  def self.up
    Category.create!(:name => 'Street Course')
  end

  def self.down
  end
end
