class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :show, :index]
  
  filter_access_to [:edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @user = User.find_by_login(params[:id]) }
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created user."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find_by_login(params[:id])
    @topics = Topic.all(:limit => 10, :include => [:user, {:forum => :guild}, :replied_by], :conditions => ["topics.user_id = ? OR topics.replied_by_id = ?", @user.id, @user.id], :order => 'updated_at DESC' )
  end
  
  def edit

  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Zapisano zmiany"
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
