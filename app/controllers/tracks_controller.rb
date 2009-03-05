class TracksController < ApplicationController
  caches_page :show
  caches_page :new
  
  FLICKR = Flickr.new("#{ENV['HOME']}/.flickr.yml")
  
  def new
    @track = Track.new
    @track.user_email = nil
    @track.added_by = nil
  end
  
  def index
    redirect_to new_search_path
  end
  
  def random
    count = Integer(Track.connection.select_value('SELECT COUNT(*) FROM tracks'))
    redirect_to root_url if count == 0

    offset = rand(count)
    @track = Track.find(:all, :conditions => 'tracks.status = 1', :limit => "#{offset},1").first
    redirect_to track_url(@track)
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
    prepare_to_show @track
  end
  
  private

  def prepare_to_show(track)
    @map = map_for @track
    @videos = find_video_for @track
    @pictures = find_photos_for @track
  end
  
  def find_video_for(track)
    search = nil
    begin
      client = YouTubeG::Client.new
      client.videos_by(:query => "#{@track.name} #{video_exclude}", :page => 1, :per_page => 5).videos
      # search = Youtube::Video.find(:first, :params => {:vq => "#{@track.name} #{video_exclude}", :"max-results" => '5'})
      # (search && Integer(search.totalResults) > 0 ? search.entry : 'No videos found')
    rescue => e
      ExceptionNotifier.deliver_exception_notification(e, self, request)
      'Sorry, the Youtube video search API is currently unavailable.'
    end
  end
  
  def video_exclude
    "-xbox -ps3 -ps2 -sim -gta -rfactor -simracing"
  end
  
  def find_photos_for(track)
    begin
      pics = FLICKR.photos.search(:text => CGI::escape(track.name), :per_page => 10, :min_upload_date => 1.year.ago.to_i)
      # Flickr's results can return pics without thumbnails or original URLs.  Need to prune these.
      pics.delete_if { |pic| !pic.url(:thumbnail) || !pic.url(:photopage) }[0..4]
      pics.size == 0 ? 'No pictures found' : pics
    rescue => e
      ExceptionNotifier.deliver_exception_notification(e, self, request)
      'Sorry, no photos to show.  The Flickr API is having problems...'
    end
  end
  
  def notify_admin(track)
    TrackMailer.deliver_summary(track)
  end
  
  def map_for(track)
  	map = GMap.new("map_div_id")
  	map.control_init(:large_map => true, :map_type => true)
  	map.center_zoom_init([@track.lat,@track.lng], 16)
  	map.set_map_type_init(GMapType::G_SATELLITE_MAP)
  	map
  end
end
