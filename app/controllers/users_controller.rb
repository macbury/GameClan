class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :show, :index]
  
  filter_access_to [:new, :create]
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

    @movies = @user.movies.all(:order=>"created_at DESC", :limit => 5)
    @events = @user.events.all(:order=>"events.when ASC", :conditions => { :when.gte => Time.now }, :limit => 10)
    @photos = @user.photos.all(:order=>"created_at DESC", :limit => 8)
  end
  
  def edit

  end
  
  def update
    if @user.update_attributes(params[:user])
      if params[:user][:avatar].blank?
        flash[:notice] = "Zapisano zmiany"
        redirect_to @user
      else
        render :action => "crop"
      end
    else
      render :action => 'edit'
    end
  end
end
