module TracksHelper
  def state_options
    SearchHelper::STATE_OPTIONS
  end
  
  def country_options
    CountryCodes.prioritized_countries_for_select(['usa', 'gbr', 'can'])
  end
end