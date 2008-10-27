require "#{File.dirname(__FILE__)}/../test_helper"

class TracksTest < ActionController::IntegrationTest
  fixtures :tracks, :track_blobs
  
  def setup
    flexmock(YouTubeG::Client).should_receive(:videos_by).and_return(youtube_mocks)
  end
  
  def test_new_track
    new_session do |anon|
      anon.goes_home
      anon.clicks_submit_track
			anon.submits_data
			anon.clicks_view_all_tracks
			anon.clicks_super_track
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
		
		def clicks_view_all_tracks
		  get '/search'
      assert_response :success
      assert_template "searches/show"
	  end
	  
    def clicks_super_track
		  assert_select 'a', :text => 'Super Track!' do |link|
		    get link[0]['href']
	    end      
      assert_response :success
      assert_template "tracks/show"
    end

    def submits_data
			before = Track.count
      post tracks_path, {:track => {:name => 'Super Track!', :address => '123 Fake St', 
				:lat => '30.45', :lng => '-100.23', :country_code => 'mex', :user_email => 'mike@tracknowledge.org',
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


  def youtube_mocks
    search = OpenStruct.new(:videos => [])
    5.times do |idx|
      search.videos << OpenStruct.new(
        :thumbnails => [OpenStruct.new(:url => "http://youtube.com/thumb#{idx}.jpg", :width => '130', :height => '97')],
        :player_url => "http://youtube.com/video#{idx}",
        :title => "Video #{idx}")
    end
    search
  end
end
