class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :limit => 64, :null => false
      t.string :fullname, :limit => 64, :null => false
      t.string :postcode, :limit => 16, :null => false
      t.string :country, :limit => 8, :null => false
      t.string :language, :limit => 8, :null => false
      t.string :timezone, :limit => 32, :null => false
      t.string :password_hash, :limit => 64
      t.string :openid_url, :limit => 128
      t.integer :role
      t.timestamps
    end
    
    add_index :users, :openid_url, :unique => true
  end

  def self.down
    drop_table :users
  end
end
