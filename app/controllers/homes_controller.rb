class HomesController < ApplicationController
  geocode_ip_address
  caches_page :legal, :about_us

  def index
    Track.cache do
      @closest = Track.all(:limit => 5)#find_within(200, :conditions => 'tracks.status = 1', :origin => current_location, :order => 'distance') if current_location
      @submitters = Track.connection.select_rows('select added_by, count(*) from tracks where status = 1 and added_by <> \'\' group by added_by order by count(*) DESC limit 5')
      @latest = Track.find(:all, :conditions => 'tracks.status = 1', :order => 'created_at DESC', :limit => 5, :include => [:categories])
    end
  end
end
