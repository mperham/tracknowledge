class HomesController < ApplicationController
  geocode_ip_address
  caches_page :legal, :about_us

  def index
    Track.cache do
      if current_location
        @closest = Track.all(:conditions => 'tracks.status = 1').sort_by {|track| track.distance_from current_location }[0..5]
      else
        @random = true
        @closest = Track.all(:limit => 5)
      end
      @submitters = Track.connection.select_rows('select added_by, count(*) from tracks where status = 1 and added_by <> \'\' group by added_by order by count(*) DESC limit 5')
      @latest = Track.find(:all, :conditions => 'tracks.status = 1', :order => 'created_at DESC', :limit => 5, :include => [:categories])
    end
  end

end
