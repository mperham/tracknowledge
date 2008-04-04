class HomesController < ApplicationController
  geocode_ip_address
  
  def index
    @closest = Track.find_nearest(:conditions => 'tracks.status = 1', :origin => current_location)
  end
end
