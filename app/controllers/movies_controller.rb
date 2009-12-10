class MoviesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :find_guild
  
	title "Filmy"

  filter_access_to [:create, :new], :attribute_check => true, 
                                    :load_method => lambda { @movie = @guild.movies.new(params[:movie]) }
  filter_access_to [:edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @movie = @guild.movies.find_by_permalink(params[:id]) }
  # GET /movies
  # GET /movies.xml
  def index
    @movies = @guild.movies.paginate :per_page => 10, :page => params[:page], :order => "title ASC"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = @guild.movies.find_by_permalink(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie.user = self.current_user

    respond_to do |format|
      if @movie.save
        flash[:notice] = 'Movie was successfully created.'
        format.html { redirect_to([@guild, @movie]) }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        flash[:notice] = 'Movie was successfully updated.'
        format.html { redirect_to([@guild, @movie]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(guild_movies_path(@guild)) }
      format.xml  { head :ok }
    end
  end

end
