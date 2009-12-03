class Topic < ActiveRecord::Base
  belongs_to :forum, :counter_cache => true
  belongs_to :user, :counter_cache => true
  belongs_to :replied_by, :class_name => "User", :foreign_key => "replied_by_id"
  
  has_many :posts, :dependent => :destroy
  has_one :recent_post, :class_name => "Post", :order => 'updated_at DESC'
  
  xss_terminate
  has_permalink :title, :update => true
  
  validates_presence_of :title, :body
  validates_length_of :title, :within => 3..80
  validates_length_of :body, :within => 3..10000
  
  attr_protected :user_id, :forum_id
  
  def to_param
    permalink
  end
  
end
