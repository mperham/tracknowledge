class User < ActiveRecord::Base
  validates_presence_of :email, :fullname, :postcode, :language, :timezone, :country
end
