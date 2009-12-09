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
		@subject = "[#{event.guild.name} - Wydarzenie] #{event.what}"
		@body[:event] = event
		@body[:event_url] = guild_event_url(event.guild, event)
		@body[:user] = user
		@body[:user_config] = edit_user_url(user)
	end
	
  protected
    
    def setup_email(user)
      @recipients  = "#{user.email}"
      #@subject     = "[mycode] "
      @sent_on     = Time.now
      @from        = ActionMailer::Base.smtp_settings[:user_name]
      @body[:user] = user
    end
end
