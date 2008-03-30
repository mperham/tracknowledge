require "pathname"
require "cgi"

require "openid"
require 'openid/store/filesystem'
require 'openid/extensions/sreg'
# end

class SessionsController < ApplicationController
  
  def show
  end
  
  FIELDS = ['fullname', 'email', 'postcode', 'language', 'timezone', 'country']
  
  # process the login request, disover the openid server, and
  # then redirect.
  def create
    openid_url = params[:openid_url]

    if request.post?
      req = consumer.begin(openid_url)
      req.add_extension_arg(OpenID::SReg::NS_URI_1_1, 'required', FIELDS * ',')

      return_to = url_for(:action => 'complete')
      trust_root = url_for(:controller=>'')

      url = req.redirect_url(trust_root, return_to)
      redirect_to(url)
      return
    end    

    render :action => 'show'
  end
  
  # handle the openid server response
  def complete
    p = params
    p.delete(:action)
    p.delete(:controller)
    response = consumer.complete(p, requested_url)

    case response.status
    when OpenID::Consumer::SUCCESS
      @user = User.find_by_openid_url(response.identity_url)
      unless @user
        @user = User.new(sreg_params(response))
        @user.address = "#{@user.postalcode} #{@user.country_code}"
        @user.save!
      end
      
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{response.identity_url}"
      redirect_to tracks_path
      return

    when OpenID::Consumer::FAILURE
      if response.identity_url
        flash[:notice] = "Verification of #{response.identity_url} failed: #{response.message}"
      else
        flash[:notice] = "Verification failed: #{response.message}"
      end

    when OpenID::Consumer::CANCEL
      flash[:notice] = 'Verification cancelled.'
    else
      flash[:notice] = 'Unknown response from OpenID server.'
    end
  
    redirect_to :action => 'show'
  end
  
  def logout
    session[:user_id] = nil
    redirect_to :action => 'show'
  end
    
  private
  
  def requested_url
    "#{request.protocol + request.host_with_port + request.relative_url_root + request.path}"
  end
  
  def sreg_params(resp)
    params = { :openid_url => resp.identity_url }
    params.merge(resp.extension_response(OpenID::SReg::NS_URI_1_1, true))
  end

  # Get the OpenID::Consumer object.
  def consumer
    # create the OpenID store for storing associations and nonces,
    # putting it in your app's db directory
    store_dir = File.join(RAILS_ROOT, 'db', 'openid-store')
    store = OpenID::Store::Filesystem.new(store_dir)

    return OpenID::Consumer.new(session, store)
  end

  # get the logged in user object
  def find_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end
  
end
