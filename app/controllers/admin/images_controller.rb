# -*- encoding : utf-8 -*-
class Admin::ImagesController < Admin::BaseController
  
  # GET /images
  # GET /images.xml
  def index
    @search = Image.search(params[:search])
    @images = @search.order("id DESC").paginate(:page => params[:page], :per_page => @per_page)
    @title = "Images Directory"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end


  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
      format.js
    end
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
      format.js
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.xml
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to(admin_image_path(@image), :notice => 'Image was successfully created.') }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to(admin_image_path(@image), :notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(admin_images_url) }
      format.xml  { head :ok }
      format.js
    end
  end
end
