module TracksHelper
  def new_state_options
    SearchHelper::STATE_OPTIONS
  end
  
  def new_country_options
    CountryCodes.prioritized_countries_for_select(['usa', 'gbr', 'can'])
  end
  
  def status_column(record)
    record.approved? ? 
      "Approved / #{link_to 'View', track_path(record), :target => '_new'}" :
      "Pending / #{link_to 'View', track_path(record), :target => '_new'} / #{link_to 'Approve', approve_admin_track_path(record)}"
  end
end