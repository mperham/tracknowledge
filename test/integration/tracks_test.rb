require "#{File.dirname(__FILE__)}/../test_helper"

class TracksTest < ActionController::IntegrationTest
  fixtures :tracks, :track_blobs
  
  def test_new_track
    new_session do |anon|
      anon.goes_home
      anon.clicks_submit_track
			anon.submits_data
    end
  end

	private
  def new_session
    open_session do |sess|
      sess.extend(Operations)
      yield sess if block_given?
    end
  end
  
  module Operations
    def goes_home
      get root_path
      assert_response :success
      assert_template "homes/index"
    end

		def clicks_submit_track
      get new_track_path
      assert_response :success
      assert_template "tracks/new"
		end

    def submits_data
			before = Track.count
      post tracks_path, {:track => {:name => 'Super Track!', :address => '123 Fake St', 
				:lat => '30.45', :lng => '-100.23', :country_code => 'mex', :user_email => 'mike@perham.net',
				:state => 'fl', :website => 'http://perham.net', :designer => 'Tilke and Associates', :capacity => '45000',
				:owner => 'Mike Perham', :year_built => '1954', :length_in_km => '6.34', :added_by => 'George', :turns => '12',
				:wikipedia_url => 'http://en.wikipedia.org/wiki/Some_track' }, :uom => 'mi'
			}
			after = Track.count
			assert_equal before + 1, after

			assert !flash.empty?
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template "homes/index"
    end
	end
end
