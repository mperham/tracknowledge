class TrackSubmissionData < ActiveRecord::Migration
  def self.up
    add_column :tracks, :added_by, :string, :null => false, :limit => 64, :default => 'tracknowledge.org'
    add_column :tracks, :user_email, :string, :null => false, :limit => 128, :default => 'admin@tracknowledge.org'
    add_column :tracks, :status, :integer, :null => false, :default => 1
  end

  def self.down
    remove_column :tracks, :added_by
    remove_column :tracks, :user_email
    remove_column :tracks, :status
  end
end
