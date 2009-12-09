class Forum < ActiveRecord::Base
  has_many :topics, :dependent => :destroy
  belongs_to :guild
  xss_terminate
  
  validates_presence_of :name, :description
  validates_length_of :name, :within => 3..34
  validates_length_of :description, :within => 0..255
  
  has_one :recent_topic, :class_name => "Topic", :order => 'updated_at DESC'
  
  has_permalink :name, :update => true
  
  attr_protected :guild_id
  
  def to_param
    permalink
  end
  
end
