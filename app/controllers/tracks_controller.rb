class TracksController < ApplicationController
  caches_page :show
  caches_page :new

  def new
    @track = Track.new
    @track.user_email = nil
    @track.added_by = nil
  end
  
  def random
    rand = Track.connection.select_value('SELECT FLOOR(RAND() * COUNT(*)) FROM tracks')
    @track = Track.find(:all, :conditions => 'tracks.status = 1', :limit => "#{rand},1").first
    @map = map_for @track
    render :action => 'show'
  end
  
  def create
    if !params[:track][:lat].blank? and params[:track][:lat] =~ /&ll=([\.\-\d]+),([\.\-\d]+)/
      params[:track][:lat] = $1
      params[:track][:lng] = $2
    end
    @track = Track.new(params[:track])
    # Update length if the user inputed in miles
    @track.length_in_km = @track.length_in_km * 1.6 if params[:uom] == 'mi'
    @track.status = (@track.user_email =~ /@tracknowledge.org/ ? 1 : 0)

    if @track.save
      notify_admin @track
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
    @map = map_for @track
  end
  
  private
  
  def notify_admin(track)
    begin
      TrackMailer.deliver_summary(track)
    rescue => e
      puts e.message
      puts e.backtrace.join("\n")
    end
  end
  
  def map_for(track)
  	map = GMap.new("map_div_id")
  	map.control_init(:large_map => true, :map_type => true)
  	map.center_zoom_init([@track.lat,@track.lng], 16)
  	map.set_map_type_init(GMapType::G_SATELLITE_MAP)
  	map
  end
end
