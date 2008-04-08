class TrackVersionsSubmissionData < ActiveRecord::Migration
  def self.up
    add_column :track_versions, :added_by, :string, :null => false, :limit => 64, :default => 'tracknowledge.org'
    add_column :track_versions, :user_email, :string, :null => false, :limit => 128, :default => 'admin@tracknowledge.org'
    add_column :track_versions, :status, :integer, :null => false, :default => 1
  end

  def self.down
    remove_column :track_versions, :added_by
    remove_column :track_versions, :user_email
    remove_column :track_versions, :status
  end
end
