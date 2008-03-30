class User < ActiveRecord::Base
  attr_accessible :address
  acts_as_mappable :auto_geocode => true
  validates_presence_of :email, :fullname, :postcode, :language, :timezone, :country
end
