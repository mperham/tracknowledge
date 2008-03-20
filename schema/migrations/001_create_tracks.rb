class CreateTracks < Sequel::Migration 
	def up 
		create_table :tracks do 
			primary_key :id 
			varchar   :name, :size => 64, :null => false, :unique => true 
			varchar   :owner, :size => 128
			varchar   :country_code, :size => 3, :null => false
			float			:longitude
			float			:latitude
			timestamp :created_at, :null => false 
			timestamp :updated_at, :null => false 
		end 
	end 

	def down 
		drop_table :tracks 
	end 
end 
