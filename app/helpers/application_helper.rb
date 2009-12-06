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
  
  def avatar_for(user, size)
    image_tag user.avatar.url(size)
  end
  
	def rss_link(title, path)
    tag :link, :type => 'application/rss+xml', :title => title, :href => path
  end

end
