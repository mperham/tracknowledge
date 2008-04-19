require 'state_helper'

module SearchHelper
  def state_options
    @@cached_states ||= begin
      valid = Track.connection.select_values("select distinct state from tracks")
      STATE_OPTIONS.dup.delete_if {|entry| not (entry[1].blank? or valid.include? entry[1])}
    end
  end
  
  def country_options
    @@cached_countries ||= begin
      valid = Track.connection.select_values("select distinct country_code from tracks")
      CountryCodes.prioritized_countries_for_select(['usa', 'gbr', 'can']).delete_if {|entry| not valid.include? entry[1] }.unshift(['', ''])
    end
  end
  
  def category_options
    @@cached_categories ||= begin
      Category.find(:all).map do |cat|
        [cat.name, cat.id.to_s]
      end.unshift([])
    end
  end
end
