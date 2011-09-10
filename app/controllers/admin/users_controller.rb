class Admin::UsersController < Admin::BaseController
  
  # GET /admin/users
  # GET /admin/users.xml
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /admin/users/1
  # GET /admin/users/1.xml
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
    
  end

  # GET /admin/users/new
  # GET /admin/users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /admin/users/1/edit
  def edit
    @user = User.find(params[:id])
  rescue
    @user = current_user
  end

  # PUT /admin/users/1
  # PUT /admin/users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        #@user.update_roles(params[:user][:role_ids])
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to edit_admin_user_path(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.xml
  def destroy
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.destroy
        flash[:success] = "User deleted"
        format.html { redirect_to(admin_users_path) }
        format.xml  { head :ok }
      else
        format.html { redirect_to(admin_users_path) }
      end
    end
  end
  
  # POST /admin/users
  # POST /admin/users.xml
  def create
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_to(admin_users_path)
      flash[:success] = "User has been created."
    else
      render :action => 'new'
    end
  end
  

  private
  
  def destroy_denied
    flash[:error] = "Error: You cannot delete this user."
    redirect_to admin_users_path
  end
  
  def record_not_found
    flash[:error] = "Error: User not found."
    redirect_to admin_users_path
  end
end
