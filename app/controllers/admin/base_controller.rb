class Admin::BaseController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_admin
  
  before_filter :set_per_page
  
  layout 'admin'
  
  protected
  
  
  def set_per_page
    if session[:per_page]
      @per_page = session[:per_page]
    else
      @per_page = 20 # Default to 20
    end
    
    if params[:per_page]
      session[:per_page] = params[:per_page]
      @per_page = session[:per_page]
    end
    
  end
    
  # check the roles of current user
  def check_admin
    if current_user && current_user.admin
      logger.info "[auth] Allowed for #{current_user.email}"
      true
    else
      logger.info ("[auth] Access Denied")
      redirect_to new_user_session
    end
  end 
  
  private
  
    def last_modified_header
      headers["last_modified"] = last_modified
    end
  
    def set_user_time_zone
      Time.zone = current_user.time_zone if logged_in?
    end
        
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
end
