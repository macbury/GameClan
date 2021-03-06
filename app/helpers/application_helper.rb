# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
	# generate pretty head title
  def title
		title = "Game Clan(BETA)"
    if !@guild.nil? && !@guild.new_record?
      #przed = @guild.typ == GT_TEAM ? 'Klan' : 'Gildia'
      title += " - #{@guild.name}"
    end

		title += " - #{@title.join(' - ')}" unless @title.nil?
		return title
  end
  
	# return image_tag with avatar for user
  def avatar_for(user, size)
    image_tag user.avatar.url(size)
  end
  
	# add rss link
	def rss_link(title, path)
    tag :link, :type => 'application/rss+xml', :title => title, :href => path
  end

end
