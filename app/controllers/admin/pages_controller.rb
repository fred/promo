class Admin::PagesController < Admin::BaseController
  
  # uses_tiny_mce :options => {
  #                             :theme => 'advanced',
  #                             :theme_advanced_resizing => true,
  #                             :theme_advanced_resize_horizontal => true,
  #                             :plugins => %w{ table fullscreen }
  # }
  
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  def home
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

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    # @page = Page.find(params[:id])
    @page = Page.where(:permalink => params[:id]).first
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
    expire_page :action => :index
    expire_page :action => :home

    respond_to do |format|
      if @page.save
        format.html { redirect_to(admin_page_path(@page), :notice => 'Page was successfully created.') }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    # @page = Page.find(params[:id])
    @page = Page.where(:permalink => params[:id]).first    

    respond_to do |format|
      if @page.update_attributes(params[:page])
        expire_page "/#{@page.permalink}"
        expire_page "/pages/#{@page.permalink}"
        # expire_page :controller => 'pages', :action => 'show', :id => @page.permalink        
        # system("rm -rf #{Rails.root}/public/#{@page.permalink}")
        # system("rm -rf #{Rails.root}/public/pages/")
        format.html { redirect_to(admin_page_path(@page), :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    # @page = Page.find(params[:id])
    @page = Page.where(:permalink => params[:id]).first
    expire_page "/#{@page.permalink}"
    expire_page "/pages/#{@page.permalink}"
    # expire_page :controller => 'pages', :action => 'show', :id => @page.permalink
    # system("rm -rf #{Rails.root}/public/#{@page.permalink}")
    # system("rm -rf #{Rails.root}/public/pages/")
    @page.destroy
    respond_to do |format|
      format.html { redirect_to(admin_pages_url) }
      format.xml  { head :ok }
    end
  end
end
