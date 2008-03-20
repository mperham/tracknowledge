class Tracks < Application
  # provides :xml, :yaml, :js
  
  def index
    @tracks = Track.all
    display @tracks
  end

  def show
    @track = Track.first(params[:id])
    raise NotFound unless @track
    display @track
  end

  def new
    only_provides :html
    @track = Track.new
    render
  end

  def edit
    only_provides :html
    @track = Track.first(params[:id])
    raise NotFound unless @track
    render
  end

  def create
    @track = Track.new(params[:track])
    if @track.save
      redirect url(:track, @track)
    else
      render :new
    end
  end

  def update
    @track = Track.first(params[:id])
    raise NotFound unless @track
    if @track.update_attributes(params[:track])
      redirect url(:track, @track)
    else
      raise BadRequest
    end
  end

  def destroy
    @track = Track.first(params[:id])
    raise NotFound unless @track
    if @track.destroy!
      redirect url(:tracks)
    else
      raise BadRequest
    end
  end
  
end
