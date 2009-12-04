class EventsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :find_guild
  
  filter_access_to [:create, :new], :attribute_check => true, 
                                    :load_method => lambda { @event = @guild.events.new(params[:event]) }
  filter_access_to [:edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @event = @guild.events.find_by_permalink(params[:id]) }
  # GET /events
  # GET /events.xml
  def index
    @month = params[:month].to_date.at_beginning_of_month rescue Date.current
    @events = @guild.events.all(:conditions => ["events.when <= ? AND events.when >= ?", @month.at_end_of_month, @month.at_beginning_of_month])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = @guild.events.find_by_permalink(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event.when = params[:date].to_date rescue Date.current
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    render :action => "new"
  end

  # POST /events
  # POST /events.xml
  def create
    @event.user = self.current_user
    
    respond_to do |format|
      if @event.save
        flash[:notice] = 'Zdarzenie zostało dodane'
        format.html { redirect_to([@guild,@event]) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Zdarzenie zostało zapisane'
        format.html { redirect_to([@guild,@event]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(guild_events_path(@guild)) }
      format.xml  { head :ok }
    end
  end
end
