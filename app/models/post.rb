class Post < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :touch => true, :counter_cache => true

  xss_terminate

  validates_length_of :body, :within => 3..10000
  
  attr_protected :user_id, :topic_id
  
end
