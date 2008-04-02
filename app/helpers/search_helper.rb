module SearchHelper
  STATE_OPTIONS = [ 	
  	['', ''],
  	['Alabama', 'AL'], 
  	['Alaska', 'AK'],
  	['Arizona', 'AZ'],
  	['Arkansas', 'AR'], 
  	['California', 'CA'], 
  	['Colorado', 'CO'], 
  	['Connecticut', 'CT'], 
  	['Delaware', 'DE'], 
  	['District Of Columbia', 'DC'], 
  	['Florida', 'FL'],
  	['Georgia', 'GA'],
  	['Hawaii', 'HI'], 
  	['Idaho', 'ID'], 
  	['Illinois', 'IL'], 
  	['Indiana', 'IN'], 
  	['Iowa', 'IA'], 
  	['Kansas', 'KS'], 
  	['Kentucky', 'KY'], 
  	['Louisiana', 'LA'], 
  	['Maine', 'ME'], 
  	['Maryland', 'MD'], 
  	['Massachusetts', 'MA'], 
  	['Michigan', 'MI'], 
  	['Minnesota', 'MN'],
  	['Mississippi', 'MS'], 
  	['Missouri', 'MO'], 
  	['Montana', 'MT'], 
  	['Nebraska', 'NE'], 
  	['Nevada', 'NV'], 
  	['New Hampshire', 'NH'], 
  	['New Jersey', 'NJ'], 
  	['New Mexico', 'NM'], 
  	['New York', 'NY'], 
  	['North Carolina', 'NC'], 
  	['North Dakota', 'ND'], 
  	['Ohio', 'OH'], 
  	['Oklahoma', 'OK'], 
  	['Oregon', 'OR'], 
  	['Pennsylvania', 'PA'], 
  	['Rhode Island', 'RI'], 
  	['South Carolina', 'SC'], 
  	['South Dakota', 'SD'], 
  	['Tennessee', 'TN'], 
  	['Texas', 'TX'], 
  	['Utah', 'UT'], 
  	['Vermont', 'VT'], 
  	['Virginia', 'VA'], 
  	['Washington', 'WA'], 
  	['West Virginia', 'WV'], 
  	['Wisconsin', 'WI'], 
  	['Wyoming', 'WY']]
  	
  def state_options
    @@cached_states ||= begin
      valid = Track.connection.select_values("select distinct state from tracks").map {|a| a.upcase}
      STATE_OPTIONS.delete_if {|entry| not (entry[1].blank? or valid.include? entry[1])}
    end
  end
  
  def country_options
    @@cached_countries ||= begin
      valid = Track.connection.select_values("select distinct country_code from tracks")
      CountryCodes.prioritized_countries_for_select(['usa', 'gbr', 'can']).delete_if {|entry| not valid.include? entry[1] }.unshift([])
    end
  end
end
