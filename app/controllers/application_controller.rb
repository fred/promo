class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  before_filter :home_page

  def home_page
    @home_page = Page.where(:permalink => "home").first
    @pages = Page.all(:order => "sort_order ASC")
  end
  
end
