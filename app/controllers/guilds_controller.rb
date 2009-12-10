class GuildsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  filter_access_to [:create, :new]
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @guild = Guild.find_by_permalink(params[:id]) }
  
  before_filter :preload_members, :only => [:edit, :update]
  # GET /guilds
  # GET /guilds.xml
  def index
		conditions = {}
		conditions = ["guilds.name ILIKE ?", "%#{params[:keyword]}%"] unless params[:keyword].nil?
    @guilds = Guild.paginate :per_page => 10, :page => params[:page], :order => "name ASC", :conditions => conditions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @guilds }
    end
  end

  # GET /guilds/1
  # GET /guilds/1.xml
  def show
    @topics = @guild.topics.all(:order=>"updated_at DESC", :include => [:user, :forum, :replied_by], :limit => 10)
    @movies = @guild.movies.all(:order=>"created_at DESC", :include => [:user], :limit => 5)
    @events = @guild.events.all(:order=>"events.when ASC", :conditions => { :when.gte => Time.now }, :limit => 10)
    @photos = @guild.photos.all(:order=>"created_at DESC", :limit => 8)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @guild }
			format.rss
    end
  end

  # GET /guilds/new
  # GET /guilds/new.xml
  def new
    @guild = Guild.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @guild }
    end
  end

  # GET /guilds/1/edit
  def edit
    
  end

  # POST /guilds
  # POST /guilds.xml
  def create
    @guild = self.current_user.guilds.new(params[:guild])

    respond_to do |format|
      if @guild.save
        flash[:notice] = 'Gildia została stworzona'
        format.html { redirect_to(@guild) }
        format.xml  { render :xml => @guild, :status => :created, :location => @guild }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @guild.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /guilds/1
  # PUT /guilds/1.xml
  def update
    respond_to do |format|
      if @guild.update_attributes(params[:guild])
        flash[:notice] = 'Zapisano zmiany'
        format.html { redirect_to(@guild) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @guild.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /guilds/1
  # DELETE /guilds/1.xml
  def destroy
    @guild.destroy

    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.xml  { head :ok }
    end
  end
  
  protected
    def preload_members
      @moderators = @guild.moderators.all(:order => 'login ASC')
      conditions = {}
      conditions = { :id.not => @moderators.map(&:id) } unless @moderators.nil? || @moderators.empty?
      @members = @guild.members.all(:order => 'login ASC', :conditions => conditions)
    end
end
