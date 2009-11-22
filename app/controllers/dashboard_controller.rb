class DashboardController < ApplicationController
  before_filter :get_guild
  def index
    
  end
  
  protected 
    
    def get_guild
      @guild = Guild.find_by_permalink(params[:guild_id])
    end
end
