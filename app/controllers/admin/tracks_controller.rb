class Admin::TracksController < AdminController
	active_scaffold :tracks do |config|
    config.list.columns.exclude [:designer, :capacity]
    config.list.sorting = [{:status => 'ASC'}, {:name => 'ASC'}]
  end
  
  def approve
    track = Track.find(params[:id])
    track.approve! unless track.approved?
    redirect_to admin_tracks_path
  end
end
