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
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

end
