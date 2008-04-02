module SearchHelper
  STATE_OPTIONS = [ 	
  	['', ''],
  	['Alabama', 'al'], 
  	['Alaska', 'ak'],
  	['Arizona', 'az'],
  	['Arkansas', 'ar'], 
  	['California', 'ca'], 
  	['Colorado', 'co'], 
  	['Connecticut', 'ct'], 
  	['Delaware', 'de'], 
  	['District Of Columbia', 'dc'], 
  	['Florida', 'fl'],
  	['Georgia', 'ga'],
  	['Hawaii', 'hi'], 
  	['Idaho', 'id'], 
  	['Illinois', 'il'], 
  	['Indiana', 'in'], 
  	['Iowa', 'ia'], 
  	['Kansas', 'ks'], 
  	['Kentucky', 'ky'], 
  	['Louisiana', 'la'], 
  	['Maine', 'me'], 
  	['Maryland', 'md'], 
  	['Massachusetts', 'ma'], 
  	['Michigan', 'mi'], 
  	['Minnesota', 'mn'],
  	['Mississippi', 'ms'], 
  	['Missouri', 'mo'], 
  	['Montana', 'mt'], 
  	['Nebraska', 'ne'], 
  	['Nevada', 'nv'], 
  	['New Hampshire', 'nh'], 
  	['New Jersey', 'nj'], 
  	['New Mexico', 'nm'], 
  	['New York', 'ny'], 
  	['North Carolina', 'nc'], 
  	['North Dakota', 'nd'], 
  	['Ohio', 'oh'], 
  	['Oklahoma', 'ok'], 
  	['Oregon', 'or'], 
  	['Pennsylvania', 'pa'], 
  	['Rhode Island', 'ri'], 
  	['South Carolina', 'sc'], 
  	['South Dakota', 'sd'], 
  	['Tennessee', 'tn'], 
  	['Texas', 'tx'], 
  	['Utah', 'ut'], 
  	['Vermont', 'vt'], 
  	['Virginia', 'va'], 
  	['Washington', 'wa'], 
  	['West Virginia', 'wv'], 
  	['Wisconsin', 'wi'], 
  	['Wyoming', 'wy']]
  	
  def state_options
    @@cached_states ||= begin
      valid = Track.connection.select_values("select distinct state from tracks")
      STATE_OPTIONS.delete_if {|entry| not (entry[1].blank? or valid.include? entry[1])}
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
