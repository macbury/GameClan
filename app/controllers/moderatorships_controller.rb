class ModeratorshipsController < ApplicationController
  before_filter :login_required
  
  filter_access_to [:destroy, :create], :attribute_check => true,
                          :load_method => lambda { @guild = Guild.find_by_permalink!(params[:guild_id]) }
                          
  def create
    @members = @guild.members.find(params[:users])
    
    @members.each do |member|
      @guild.assign_moderator(member)
    end
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @moderatorships = @guild.moderatorships.all(:conditions => { :user_id.in => params[:users] })
    @members = @guild.members.find(params[:users])
    
    @moderatorships.each(&:destroy)
    
    respond_to do |format|
      format.js
    end
  end
end
