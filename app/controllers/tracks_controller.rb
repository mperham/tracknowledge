class TracksController < ApplicationController
  def index
    @tracks = Track.paginate :page => params[:page]
  end
  
  def new
    @track = Track.new
  end
  
  def create
    @track = Track.new(params[:track])
    if @track.save
      flash[:notice] = 'Your track entry has been submitted. Thank you!'
      redirect_to root_path
    else
      err = @track.errors.each_full { |msg| msg }.join('<br/>')
      flash[:error] = "There are errors in your submission:<br/>#{err}"
      render :action => 'new'
    end
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
