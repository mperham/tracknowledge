class TracksController < ApplicationController
  def index
    @tracks = Track.paginate :page => params[:page]
  end
  
  def new
    @track = Track.new
    @track.user_email = nil
    @track.added_by = nil
  end
  
  def random
    rand = Track.connection.select_value('SELECT FLOOR(RAND() * COUNT(*)) FROM tracks')
    @track = Track.find(:all, :conditions => 'tracks.status = 1', :limit => "#{rand},1").first
    render :action => 'show'
  end
  
  def create
    @track = Track.new(params[:track])
    # Update length if the user inputed in miles
    @track.length_in_km = @track.length_in_km * 1.6 if params[:uom] == 'mi'
    @track.status = 0

    if @track.save
      flash[:notice] = 'Your track entry has been submitted.  NOTE: It will not be visible until it has verified by our editors. Thank you!'
      redirect_to root_path
    else
      @track.length_in_km = params[:track][:length_in_km]
      err = @track.errors.each_full { |msg| msg }.join('<br/>')
      flash[:error] = "There are errors in your submission:<br/>#{err}"
      render :action => 'new'
    end
  end
  
  def show
    @track = Track.find(params[:id], :include => [:track_blob, :categories])
    if @track.lat and @track.lng
    	@map = GMap.new("map_div_id")
    	@map.control_init(:large_map => true, :map_type => true)
    	@map.center_zoom_init([@track.lat,@track.lng], 16)
    	@map.set_map_type_init(GMapType::G_SATELLITE_MAP)
  	end
  end
end
