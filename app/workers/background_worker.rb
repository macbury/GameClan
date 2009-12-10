class BackgroundWorker < Workling::Base
  
  def convert(options)
    movie = Movie.find(options[:movie_id])
    
    #Dir.mkdir("#{RAILS_ROOT}/tmp/videos/output/")
    
    file_name = File.basename(movie.clip.path, '.*') + '.flv'
    thumb_name = File.basename(movie.clip.path, '.*') + '.jpg'
    
    output_file = "#{RAILS_ROOT}/tmp/videos/output/#{file_name}"
    thumb_file  = "#{RAILS_ROOT}/tmp/videos/output/#{thumb_name}"
    
    logger.debug "Konwersja filmu...."
    
    recipe = "ffmpeg -i $input_file$ -s 480x360 -acodec mp3 -ac 1 -ar 22050 -b 1300k -r 20 -aspect 4:3 -vcodec flv  -flags +aic+cbp+mv0+mv4+trell -y $output_file$ \n"
    recipe += "flvtool2 -U $output_file$ \n"
    recipe += "ffmpeg -i $input_file$ -ss 5 -s 480x360 -vframes 1 -f image2 -an #{thumb_file}"
    
    transcoder = RVideo::Transcoder.new
    
    begin
      transcoder.execute(recipe, {:input_file => movie.clip.path, :output_file => output_file})
      movie.processing = true
      movie.save
    rescue TranscoderError => e
      movie.destroy
      logger.debug "Unable to transcode file: #{e.class} - #{e.message}"
      return
    end
    
    logger.debug "Deleting temp file..."
    
    File.delete(movie.clip.path)
    movie.video = File.new(output_file, 'r')
    movie.preview = File.new(thumb_file, 'r')
    
    duration = transcoder.original.duration.split(':') rescue [0,0,0]

    hour = duration[0].to_i * 3600
    min = duration[1].to_i * 60
    sec = duration[2].to_i
    movie.duration = hour + min + sec
    
    movie.processing = false
    movie.mail_notification

    movie.save
    
    File.delete(output_file)
    File.delete(thumb_file)
  end
  
  def send_comment_notification(options)
    comment = Comment.find(options[:comment_id])
    
    users_id = comment.commentable.comments.all(:select => 'user_id', :conditions => { :user_id.not => comment.user_id }, :group => 'user_id').map(&:user_id)
    
    users_id = [] if users_id.nil?
    
    users_id << comment.commentable.user_id if comment.user_id != comment.commentable.user_id
    
    users = User.all(:conditions => { :id.in => users_id } )
    
    users.each do |user|
      Notifier.deliver_comment(comment, user)
    end
    
  end
  
  def deliver_event_notification(options)
    event = Event.find(options[:event_id])
    recipients = event.guild.members.all(:conditions => { :notification_events => true })

    recipients.each do |recipient|
      Mailer.deliver_event(event,recipient)
    end
  end
  
  def deliver_photo_notification(options)
    photo = Photo.find(options[:photo_id])
    recipients = photo.guild.members.all(:conditions => { :notification_photos => true })

    recipients.each do |recipient|
      Mailer.deliver_photo(photo,recipient)
    end
  end
	
	def deliver_movie_notification(options)
    movie = Movie.find(options[:movie_id])
    recipients = movie.guild.members.all(:conditions => { :notification_movies => true })

    recipients.each do |recipient|
      Mailer.deliver_movie(movie,recipient)
    end
  end
	
	def deliver_topic_notification(options)
    topic = Topic.find(options[:topic_id])
    recipients = topic.forum.guild.members.all(:conditions => { :notification_posts => true })

    recipients.each do |recipient|
      Mailer.deliver_topic(topic,recipient)
    end
  end
	
	def deliver_new_membership_notification(options)
    member = Membership.find(options[:membership_id])
    moderators = topic.forum.guild.moderators.all

    moderators.each do |moderator|
      Mailer.deliver_membership(member, moderator)
    end
  end
	
end