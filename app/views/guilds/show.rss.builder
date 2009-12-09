xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title title
    xml.link guild_url(@guild)
    
    for topic in @topics
			post = topic.recent_post.nil? ? topic : topic.recent_post
      xml.item do
        xml.title "[Forum] - #{topic.title}"
        xml.description "#{post.user.login}: #{truncate(post.body, :length => 512)}"
        xml.pubDate topic.updated_at.to_s(:rfc822)
        xml.link guild_forum_topic_url(@guild, topic.forum, topic)
        xml.guid guild_forum_topic_url(:guild_id => @guild.permalink, :forum_id => topic.forum.permalink, :id => topic.permalink, :uid => post.id.to_s(32))
      end
    end
    
		for movie in @movies
      xml.item do
        xml.title "[Film] - #{movie.title}"
        xml.description image_tag(movie.preview.url(:small))
        xml.pubDate movie.created_at.to_s(:rfc822)
        xml.link guild_movie_url(@guild, movie)
        xml.guid guild_movie_url(@guild, movie)
      end
    end
		
		for event in @events
      xml.item do
        xml.title "[Wydarzenie] - #{event.where}"
        xml.description event.what 
        xml.pubDate event.created_at.to_s(:rfc822)
        xml.link guild_event_url(@guild, event)
        xml.guid guild_event_url(@guild, event)
      end
    end
		
		for photo in @photos
      xml.item do
        xml.title "[Zdjęcie] - ##{photo.id}"
        xml.description image_tag(photo.image.url(:forum))
        xml.pubDate photo.created_at.to_s(:rfc822)
        xml.link guild_event_url(@guild, photo)
        xml.guid guild_event_url(@guild, photo)
      end
    end
		
  end
end