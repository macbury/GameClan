class TopicsController < ApplicationController
  before_filter :login_required, :except => [:show]
  before_filter :load_resources
  
  filter_access_to [:create, :new]
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @topic = @forum.topics.find_by_permalink(params[:id]) }
  # GET /topics/1
  # GET /topics/1.xml
  
  def index
    redirect_to guild_forum_path(@guild, @forum)
  end
  
  def show
    @posts = @topic.posts.all(:order => 'created_at ASC', :include => [:user] )
    @posts.insert(0, @topic)
    
    @post = @topic.posts.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    render :action => "new"
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = self.current_user.topics.new(params[:topic])
    @topic.forum = @forum
    
    respond_to do |format|
      if @topic.save
        flash[:notice] = 'Temat został dodany'
        format.html { redirect_to([@guild, @forum, @topic]) }
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Temat został zapisany.'
        format.html { redirect_to([@guild, @forum, @topic]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to([@guild, @forum]) }
      format.xml  { head :ok }
    end
  end
  
  protected
    
    def load_resources
      @guild = Guild.find_by_permalink(params[:guild_id])
      @forum = @guild.forums.find_by_permalink(params[:forum_id])
    end
    
end
