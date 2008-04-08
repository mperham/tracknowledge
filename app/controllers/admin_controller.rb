class AdminController < ApplicationController
  before_filter :ensure_admin
  
  private
  
  def ensure_admin
    redirect_to session_path unless @user and @user.is_admin?
  end
end

module Admin
end