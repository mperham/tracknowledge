class HomesController < ApplicationController
  geocode_ip_address
  caches_page :legal

  def index
    @closest = Track.find_within(500, :conditions => 'tracks.status = 1', :origin => current_location) if current_location
    @submitters = Track.connection.select_rows('select added_by, count(*) from tracks group by added_by limit 5')
  end
end
