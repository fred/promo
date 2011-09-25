class Admin::SnippetsController < Admin::BaseController

  # GET /snippets
  # GET /snippets.xml
  def index
    @per_page = 20
    @search = Snippet.search(params[:search])
    @snippets = @search.order(:title).paginate(:page => params[:page], :per_page => @per_page)
    @title = "Pages Directory"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @snippets }
    end
  end

  def home
  end
  
  # GET /snippets/1
  # GET /snippets/1.xml
  def show
    @snippet = Snippet.where(:permalink => params[:permalink]).first if params[:permalink]
    @snippet = Snippet.where(:permalink => params[:id]).first if params[:id]
    # @snippet = Snippet.where(:permalink => params[:id]).first
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @snippet }
    end
  end

  # GET /snippets/new
  # GET /snippets/new.xml
  def new
    @snippet = Snippet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @snippet }
    end
  end

  # GET /snippets/1/edit
  def edit
    # @snippet = Snippet.find(params[:id])
    @snippet = Snippet.where(:permalink => params[:id]).first
  end

  # POST /snippets
  # POST /snippets.xml
  def create
    @snippet = Snippet.new(params[:snippet])

    respond_to do |format|
      if @snippet.save
        FileUtils.rm_rf "#{Rails.root}/public/pages"
        FileUtils.rm_rf "#{Rails.root}/public/index.html"
        format.html { redirect_to(admin_snippet_path(@snippet), :notice => 'Snippet was successfully created.') }
        format.xml  { render :xml => @snippet, :status => :created, :location => @snippet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @snippet.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # PUT /snippets/1
  # PUT /snippets/1.xml
  def update
    # @snippet = Snippet.find(params[:id])
    @snippet = Snippet.where(:permalink => params[:id]).first    

    respond_to do |format|
      if @snippet.update_attributes(params[:snippet])
        FileUtils.rm_rf "#{Rails.root}/public/pages"
        FileUtils.rm_rf "#{Rails.root}/public/index.html"
        format.html { redirect_to(admin_snippet_path(@snippet), :notice => 'Snippet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @snippet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.xml
  def destroy
    # @snippet = Snippet.find(params[:id])
    @snippet = Snippet.where(:permalink => params[:id]).first
    expire_snippet "/#{@snippet.permalink}"
    expire_snippet "/snippets/#{@snippet.permalink}"
    # expire_snippet :controller => 'snippets', :action => 'show', :id => @snippet.permalink
    # system("rm -rf #{Rails.root}/public/#{@snippet.permalink}")
    # system("rm -rf #{Rails.root}/public/snippets/")
    @snippet.destroy
    respond_to do |format|
      format.html { redirect_to(admin_snippets_url) }
      format.xml  { head :ok }
    end
  end
end
