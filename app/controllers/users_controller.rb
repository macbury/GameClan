class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :show, :index]
  
  filter_access_to [:new, :create]
  filter_access_to [:edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @user = User.find_by_login!(params[:id]) }
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Zostałeś zarejestrowany w serwisie!"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find_by_login(params[:id])
		@guilds = @user.guild_member.all(:order => "name ASC")
		guilds_id = @guilds.map(&:id)
		
		@topics = Topic.all(:limit => 10, :include => [:user, {:forum => :guild}, :replied_by], :conditions => ["guilds.id IN (?)", guilds_id], :order => 'topics.updated_at DESC')
		@movies = Movie.all( :order=>"created_at DESC", :limit => 5, :joins => [:guild], :conditions => ["guilds.id IN (?)", guilds_id])
		@events = Event.all( :order=> "events.when ASC", :limit => 10, :joins => [:guild], :conditions => ["guilds.id IN (?) AND events.when >= ?", guilds_id, Time.now])
		@photos = Photo.all( :order=>"created_at DESC", :limit => 8, :joins => [:guild], :conditions => ["guilds.id IN (?)", guilds_id])

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
