class MembersController < ApplicationController
  before_filter :login_required, :except => [:index]
  
  filter_access_to :all, :attribute_check => true,
                         :load_method => lambda { @guild = Guild.find_by_permalink(params[:guild_id]) }
  
  def create
    @membership = self.current_user.memberships.new(params[:membership])
    @membership.guild_id = @guild.id
    
    if @membership.save
      flash[:notice] = "Podanie zostało wysłane i oczekuje na akceptację."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @member = @guild.memberships.find(params[:id])
    @member.destroy
    flash[:notice] = "Użytkownik został odrzucony."
    redirect_to guild_members_path(@guild)
  end
  
  def leave
    @member = self.current_user.memberships.find_by_guild_id(@guild.id)
    @member.destroy
    flash[:notice] = "Opuściłeś gildie"
    redirect_to root_path
  end
  
  def index
    @members = @guild.memberships.all(:include => :user,:order => 'memberships.accepted, users.login ASC')
  end
  
  def accept
    @member = @guild.memberships.find(params[:id])
    @member.accept!
    
    flash[:notice] = "Gracz został zaakceptowany"
    
    redirect_to guild_members_path(@guild)
  end
  
  def reason
    @membership = @guild.memberships.find(params[:id])
    
    render :inline => "<%= simple_format(@membership.reason) %>", :layout => false
  end
  
  def new
    @membership = Membership.new
  end
end
