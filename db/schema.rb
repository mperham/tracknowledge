# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 2) do

  create_table "tracks", :force => true do |t|
    t.string   "name",         :limit => 64,  :null => false
    t.string   "owner",        :limit => 128
    t.string   "country_code", :limit => 3,   :null => false
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",         :limit => 64,  :null => false
    t.string   "fullname",      :limit => 64,  :null => false
    t.string   "postcode",      :limit => 16,  :null => false
    t.string   "country",       :limit => 8,   :null => false
    t.string   "language",      :limit => 8,   :null => false
    t.string   "timezone",      :limit => 32,  :null => false
    t.string   "password_hash", :limit => 64
    t.string   "openid_url",    :limit => 128
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["openid_url"], :name => "index_users_on_openid_url", :unique => true

end
