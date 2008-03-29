class TracksController < ApplicationController
  def index
    @tracks = Track.paginate :page => params[:page]
  end
  
  def show
    @track = Track.find(params[:id])
    if @track.latitude and @track.longitude
    	@map = GMap.new("map_div_id")
    	@map.control_init(:large_map => true, :map_type => true)
    	@map.center_zoom_init([@track.latitude,@track.longitude], 16)
  	end
  end
end
