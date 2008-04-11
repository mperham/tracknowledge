# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  ActiveScaffold.set_defaults do |config| 
    config.ignore_columns.add [:created_at, :updated_at, :lock_version, :version, :password_hash, :versions, :track_blob]
  end
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
    @user || session[:geo_location]
  end
end
