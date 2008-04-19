module HomeHelper
  def location_of(track)
    track.state.blank? ? track.country : "#{track.state_name}, USA"
  end
end
