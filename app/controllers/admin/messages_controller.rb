# -*- encoding : utf-8 -*-
class Admin::MessagesController < Admin::BaseController
  
  # GET /messages
  # GET /messages.xml
  def index
    @search = Message.search(params[:search])
    @messages = @search.order("id DESC").paginate(:page => params[:page], :per_page => @per_page)
    @title = "Messages Directory"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
      format.text { @messages = Message.all }
    end
  end


  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])
    # # udpate unread message to read
    if @message.unread
      @message.update_attributes(:unread => false)
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:notice] = 'Message was successfully updated.'
      redirect_to(:action => "index")
    else
      render :action => "edit"
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    if @message.destroy 
      flash[:notice] = "Message deleted"
    else
      flash[:notice] = "Message could not be deleted"
    end
    redirect_to(:action => "index")
  end
  
end
