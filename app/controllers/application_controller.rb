# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout  'application'
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'd52155a1a4e6d990522ea5b57c6ebb5e'
  
  before_filter :load_user
  
  def load_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end
  
  def admin?
    @user && @user.is_admin?
  end
  
  def current_location
    @user || begin
      loc = session[:geo_location]
      case loc
      when YAML::Object
        [loc.ivars[:lat],loc.ivars[:lng]]
      else
        loc
      end
    end
  end
end
