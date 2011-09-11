class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  before_filter :home_page

  def home_page
    @home_page = Page.where(:permalink => "home").first
    @pages = Page.all(:order => "sort_order ASC")
    

    @footer_left = Snippet.where(:permalink => "footer_left").first
    @twitter_username = Snippet.where(:permalink => "twitter_username").first
    @footer_copyright = Snippet.where(:permalink => "footer_copyright").first
    @last_box_right = Snippet.where(:permalink => "last_box_right").first
    @last_box_left = Snippet.where(:permalink => "last_box_left").first
    @box_center = Snippet.where(:permalink => "box_center").first
  end
  
end
