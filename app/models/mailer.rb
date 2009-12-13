class Mailer < ActionMailer::Base
  include ActionController::UrlWriter
  
  def comment(comment, user)
    setup_email(user)
    @subject = "#{user.login} również dodał(a) komentarz do #{comment.commentable.name}"
    
    @body[:commentable_name] = comment.commentable.name
    @body[:comment] = comment
    
    params = {:school_id => comment.commentable.school_id, :id => comment.commentable_id}
  
    if comment.commentable_type == 'Movie'
      url = school_movie_url(params)
    elsif comment.commentable_type == 'Picture'
      url = school_picture_url(params)
    else
      url = school_story_url(params)
    end
    
    @body[:url] = "#{url}#comment_#{comment.id}"
  end
	
	def event(event, user)
		setup_email(user)
		@subject = "[#{event.guild.name}] użytkownik #{user.login} dodał nowe wydarzenie"
		@body[:event] = event
		@body[:event_url] = guild_event_url(event.guild, event)
		@body[:user] = user
		@body[:user_config] = edit_user_url(user)
	end
	
	def photo(photo, user)
		setup_email(user)
		@subject = "[#{photo.guild.name}] użytkownik #{user.login} dodał nowe zdjęcie"
		@body[:photo] = photo
		@body[:photo_url] = guild_photo_url(photo.guild, photo)
		@body[:user] = user
		@body[:user_config] = edit_user_url(user)
	end
	
	def movie(movie, user)
		setup_email(user)
		@subject = "[#{photo.guild.name}] użytkownik #{user.login} dodał nowy film"
		@body[:movie] = movie
		@body[:movie_url] = guild_movie_url(movie.guild, movie)
		@body[:user] = user
		@body[:user_config] = edit_user_url(user)
	end
	
	def topic(topic, user)
		setup_email(user)
		@subject = "[#{topic.forum.guild.name}] Nowy post w wątku: '#{topic.title}'"
		@body[:topic] = topic
		@body[:topic_url] = guild_forum_topic_url(topic.forum.guild, topic.forum, topic)
		@body[:user] = user
		@body[:user_config] = edit_user_url(user)
	end
	
	def membership(membership, user)
		setup_email(user)
		@subject = "[#{membership.guild.name}] Nowe podanie o wstąpienie do gildii"
		@body[:membership] = membership
		@body[:accept_url] = accept_guild_member_url(membership.guild, membership)
		@body[:destroy_url] = destroy_guild_member_url(membership.guild, membership)
		@body[:user_url] = user_url(membership.user)
		
	end
	
	def guild_accept(membership)
		setup_email(membership.user)
		@subject = "[#{membership.guild.name}] Zostałeś przyjęty do gildii"
		@body[:membership] = membership
		@body[:guild_url] = guild_url(membership.guild)
	end
	
  protected
    
    def setup_email(user)
      @recipients  = "#{user.email}"
      #@subject     = "[mycode] "
      @sent_on     = Time.now
      @from        = ActionMailer::Base.smtp_settings[:from]
      @body[:user] = user
			default_url_options[:host] = "game-clan.megiteam.pl"
			
    end
end
