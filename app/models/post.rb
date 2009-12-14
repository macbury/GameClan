class Post < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :touch => true, :counter_cache => true

  xss_terminate
	
	validates_presence_of :body
  validates_length_of :body, :within => 3..10000
  
  attr_protected :user_id, :topic_id
  
	after_create :mail_notification
	
	def mail_notification
		#BackgroundWorker.new.deliver_topic_notification(:topic_id => self.topic.id, :post_id => self.id)
		BackgroundWorker.asynch_deliver_topic_notification(:topic_id => self.topic.id, :post_id => self.id)
	end

end
