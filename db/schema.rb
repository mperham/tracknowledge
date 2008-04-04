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

ActiveRecord::Schema.define(:version => 7) do

  create_table "categories", :force => true do |t|
    t.string "name", :limit => 32, :default => "", :null => false
  end

  create_table "track_blobs", :force => true do |t|
    t.text "notes", :default => "", :null => false
    t.text "tags",  :default => "", :null => false
    t.text "text",  :default => "", :null => false
  end

  create_table "track_categories", :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "track_id",    :null => false
  end

  create_table "track_versions", :force => true do |t|
    t.integer  "track_id"
    t.integer  "version"
    t.string   "name",          :limit => 64,  :default => ""
    t.string   "owner",         :limit => 128
    t.string   "country_code",  :limit => 3,   :default => ""
    t.float    "lng"
    t.float    "lat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year_built"
    t.string   "designer",      :limit => 64
    t.float    "length_in_km"
    t.string   "address",       :limit => 128
    t.string   "website",       :limit => 128
    t.string   "state",         :limit => 2
    t.integer  "track_blob_id"
  end

  create_table "tracks", :force => true do |t|
    t.string   "name",          :limit => 64,  :default => "",                        :null => false
    t.string   "owner",         :limit => 128
    t.string   "country_code",  :limit => 3,   :default => "",                        :null => false
    t.float    "lng"
    t.float    "lat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version"
    t.integer  "year_built"
    t.string   "designer",      :limit => 64
    t.float    "length_in_km"
    t.string   "address",       :limit => 128
    t.string   "website",       :limit => 128
    t.string   "state",         :limit => 2
    t.integer  "track_blob_id",                                                       :null => false
    t.string   "added_by",      :limit => 64,  :default => "tracknowledge.org",       :null => false
    t.string   "user_email",    :limit => 128, :default => "admin@tracknowledge.org", :null => false
    t.integer  "status",                       :default => 1,                         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",         :limit => 64,  :default => "", :null => false
    t.string   "fullname",      :limit => 64,  :default => "", :null => false
    t.string   "postcode",      :limit => 16,  :default => "", :null => false
    t.string   "country",       :limit => 8,   :default => "", :null => false
    t.string   "language",      :limit => 8,   :default => "", :null => false
    t.string   "timezone",      :limit => 32,  :default => "", :null => false
    t.string   "password_hash", :limit => 64
    t.string   "openid_url",    :limit => 128
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lng"
  end

  add_index "users", ["openid_url"], :name => "index_users_on_openid_url", :unique => true

end
