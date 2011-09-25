class PagesController < ApplicationController
  caches_page :index, :show, :home
  
  # GET /pages
  # GET /pages.xml
  def index
    redirect_to :action => "home"
  end

  def home
    @page = @home_page
  end
  
  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.where(:permalink => params[:permalink]).first if params[:permalink]
    @page = Page.where(:permalink => params[:id]).first if params[:id]
    # @page = Page.where(:permalink => params[:id]).first
    @page = @home_page if @page.nil?
    
    @meta_title = @page.meta_title
    @meta_keywords = @page.meta_keywords
    @meta_description = @page.meta_description
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end

end
