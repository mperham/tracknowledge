class HomesController < ApplicationController
  geocode_ip_address
  caches_page :legal, :about_us

  def index
    Track.cache do
      @closest = Track.find_within(200, :conditions => 'tracks.status = 1', :origin => current_location, :order => 'distance') if current_location
      @submitters = Track.connection.select_rows('select added_by, count(*) from tracks where status = 1 and added_by <> \'\' group by added_by order by count(*) DESC limit 5')
#      @track_count = Track.count(:conditions => 'tracks.status = 1')
    end
  end
end
