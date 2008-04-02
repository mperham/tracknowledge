module TracksHelper
  def new_state_options
    SearchHelper::STATE_OPTIONS
  end
  
  def new_country_options
    CountryCodes.prioritized_countries_for_select(['usa', 'gbr', 'can'])
  end
end