module CountryCodes # :nodoc:
  def self.method_missing(name, *args)
    if match = /find_([^_]*)_by_([^_]*)/.match(name.to_s)
      raise "1 argument expected, #{args.size} provided." unless args.size == 1
      
      required = match[1]
      request  = match[2]
      if valid_attributes.include?(request) && valid_attributes.include?(required)
        @countries[request][args[0].to_s.downcase][required.to_sym] || nil rescue nil
      else
        raise "#{request} is not a valid attribute, valid attributes for find_*_by_* are: #{valid_attributes.join(', ')}."
      end
      
    elsif match = /find_by_(.*)/.match(name.to_s)
      raise "1 argument expected, #{args.size} provided." unless args.size == 1
      
      request = match[1]     
      if valid_attributes.include?(request)  
        @countries[request][args[0].to_s.downcase] || nil_countries_hash
      else
        raise "#{request} is not a valid attribute, valid attributes for find_by_* are: #{valid_attributes.join(', ')}."
      end
      
    else
      raise NoMethodError.new("Method '#{name}' not supported")
    end
  end
  
  def self.countries_for_select(*args)
    # Ensure that each of the arguments is a valid attribute
    args.each do |arg|
      unless valid_attributes.include?(arg)
        raise "#{arg} is not a valid attribute, valid attributes are: #{valid_attributes.join(', ')}"
      end
    end
    
    # Build and return the desired array
    @countries[@countries.keys.first].map do |index, country|
      args.map { |a| country[a.to_sym] }
    end
  end

  def self.prioritized_countries_for_select(prioritized=[])
    if not prioritized.all? { |a3| @countries['a3'][a3] }
      raise "Invalid a3 in priorized list: #{prioritized.inspect}"
    end
    sort(country_data, prioritized)
  end

  def self.country_options_for_select(selected=nil, prioritized=[])
    if selected and not @countries['a3'][selected]
      raise "No such a3 for country: #{selected}"
    end
    if not prioritized.all? { |a3| @countries['a3'][a3] }
      raise "Invalid a3 in priorized list: #{prioritized.inspect}"
    end
    
    sort(country_data, prioritized).map do |entry|
      seltxt = selected and selected.casecmp(entry[1]) == 0 ? " selected='selected'" : ''
      "<option value='#{entry[1]}'#{seltxt}>#{entry[0]}</option>\n"
    end.join
  end

  def self.valid_attributes
    @countries.keys
  end
  
  def self.nil_countries_hash
    hash = {}
    valid_attributes.map { |attribute| hash[attribute.to_sym] = nil }
    hash
  end
  
  def self.load_countries_from_yaml
    # Load countries
    countries_from_file = YAML::load(File.open(File.join(File.dirname(__FILE__), "countries.yml")))
    
    # Build indexes for each attribute
    @countries = {}    
    countries_from_file.first.keys.each do |key|
      @countries[key.to_s] = {}
      countries_from_file.each { |country| @countries[key.to_s][country[key].to_s.downcase] = country }
    end
  end
  
  private
  
  def self.country_data
    @countries[@countries.keys.first].map do |index, country|
      [country[:name], country[:a3].downcase]
    end.sort_by {|a| a[0]}
  end
  
  def self.sort(raw_array, prioritized_list)
    prioritized_list.reverse.each do |entry|
      idx = nil
      raw_array.each_with_index {|raw, index| raw[1].casecmp(entry) == 0 ? idx = index : nil}
      raw_array.unshift(raw_array.delete_at(idx))
    end
    raw_array
  end
end
