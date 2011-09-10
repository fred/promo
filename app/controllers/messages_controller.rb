class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    redirect_to root_path
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    # @message = Message.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    @message.remote_ip = request.remote_ip
    @message.referrer  = request.referrer
    @message.user_agent = request.env["HTTP_USER_AGENT"]

    respond_to do |format|
      if @message.save
        Thread.new do
          MessageMailer.new_message(@message).deliver
        end
        format.html { redirect_to(@message, :notice => 'Thank you for you message. We will contact you soon.') }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
