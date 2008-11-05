require File.dirname(__FILE__) + '/../test_helper'

class TrackTest < ActiveSupport::TestCase
  
  def test_validation
    assert Track.new(valid_attributes).valid?
    assert_not Track.new(valid_attributes.merge({:wikipedia_url => 'http://fr.wikipedia.org/wiki/Some_Track'})).valid?
    assert_not Track.new(valid_attributes.merge({:turns => '1.2'})).valid?
  end
  
  private
  
  def valid_attributes
    {
      :name => 'Super Track!', :address => '123 Fake St', 
			:lat => '30.45', :lng => '-100.23', :country_code => 'mex', :user_email => 'mike@perham.net',
			:state => 'fl', :website => 'http://perham.net', :designer => 'Tilke and Associates', :capacity => '45000',
			:owner => 'Mike Perham', :year_built => '1954', :length_in_km => '6.34', :added_by => 'George',
			:wikipedia_url => 'http://en.wikipedia.org/wiki/Some_Track', :turns => '12'
		}
  end
end
