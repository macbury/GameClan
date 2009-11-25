# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def title
    if !@guild.nil? && !@guild.new_record?
      przed = @guild.typ == GT_TEAM ? 'Klan' : 'Gildia'
      "#{przed} #{@guild.name}"
    else
      "Game Clan"
    end
  end
  
end
