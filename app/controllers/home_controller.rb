class HomeController < ApplicationController
  geocode_ip_address
  
  def index
    @closest = Track.find_nearest(:origin => current_location)
  end
end
