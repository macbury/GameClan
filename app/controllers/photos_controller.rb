class PhotosController < ApplicationController
	before_filter :login_required, :except => [:index, :show]
	before_filter :find_guild
  
	title "Zdjęcia"

  filter_access_to [:create, :new], :attribute_check => true, 
                                    :load_method => lambda { @photo = @guild.photos.new(params[:photo]) }
  filter_access_to [:edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @photo = @guild.photos.find(params[:id]) }
  # GET /photos
  # GET /photos.xml
  def index
    @photos = @guild.photos.paginate :per_page => 10, :page => params[:page], :order => "created_at ASC"
		@photo = @guild.photos.new
		
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = @guild.photos.find(params[:id])
		@next = @guild.photos.first(:conditions => { :id.gt => @photo.id }, :order => 'created_at ASC')
		@back = @guild.photos.first(:conditions => { :id.lt => @photo.id }, :order => 'created_at DESC')
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # POST /photos
  # POST /photos.xml
  def create
		@photo.user = self.current_user
    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Zdjęcie zostało dodane.'
        format.html { redirect_to([@guild, @photo]) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
				flash[:error] = 'Nie można dodać zdjęcia.'
        format.html { redirect_to([@guild, @photo]) }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Zdjęcie zostało zapisane'
        format.html { redirect_to([@guild, @photo]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(guild_photos_url(@guild)) }
      format.xml  { head :ok }
    end
  end
end
