module TopicsHelper
  
  def link_to_topic(topic)
    url = []
    if @guild.nil?
      url << topic.forum.guild
    else
      url << @guild
    end
    
    if @forum.nil?
      url << topic.forum
    else
      url << @forum
    end

    url << topic
    
    link_to topic.title, url
  end
  
  def user_roles(user)
    if user.role
      
    end
  end
  
end
