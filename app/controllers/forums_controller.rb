class ForumsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :find_guild
  
  filter_access_to [:create, :new], :attribute_check => true, 
                                    :load_method => lambda { @forum = @guild.forums.new(params[:forum]) }
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @forum = @guild.forums.find_by_permalink(params[:id]) }
  # GET /forums
  # GET /forums.xml
  def index
    @forums = @guild.forums.all(:order => 'position ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    @topics = @forum.topics.paginate(:order=>"sticky DESC, updated_at DESC", :include => [:user, :replied_by], :per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/new
  # GET /forums/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/1/edit
  def edit
    render :action => "new"
  end

  # POST /forums
  # POST /forums.xml
  def create
    respond_to do |format|
      if @forum.save
        flash[:notice] = 'Forum zostało utworzone!'
        format.html { redirect_to([@guild, @forum]) }
        format.xml  { render :xml => @forum, :status => :created, :location => @forum }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        flash[:notice] = 'Forum was successfully updated.'
        format.html { redirect_to(@forum) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to(guild_forums_path(@guild)) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
    def find_guild
      @guild = Guild.find_by_permalink(params[:guild_id])
    end
end
