class TracksController < ApplicationController
  def index
    @tracks = Track.paginate :page => params[:page]
  end
  
  def show
    @track = Track.find(params[:id])
    if @track.lat and @track.lng
    	@map = GMap.new("map_div_id")
    	@map.control_init(:large_map => true, :map_type => true)
    	@map.center_zoom_init([@track.lat,@track.lng], 16)
  	end
  end
end
