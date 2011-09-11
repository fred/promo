class SnippetsController < ApplicationController
  
  # GET /snippets
  # GET /snippets.xml
  def index
    redirect_to :action => "home"
  end

  def home
    @snippet = @home_snippet
  end
  
  # GET /snippets/1
  # GET /snippets/1.xml
  def show
    @snippet = Snippet.where(:permalink => params[:permalink]).first if params[:permalink]
    @snippet = Snippet.where(:permalink => params[:id]).first if params[:id]
    # @snippet = Snippet.where(:permalink => params[:id]).first
    @snippet = @home_snippet if @snippet.nil?
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @snippet }
    end
  end

end
