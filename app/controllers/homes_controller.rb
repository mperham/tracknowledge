class HomesController < ApplicationController
  geocode_ip_address
  
  def index
    @closest = Track.find_within(500, :conditions => 'tracks.status = 1', :origin => current_location) if current_location
  end
end
