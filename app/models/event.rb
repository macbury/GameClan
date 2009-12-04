class Event < ActiveRecord::Base
  xss_terminate
  has_permalink :what, :update => true
  
  attr_protected :guild_id, :user_id
  
  belongs_to :user
  belongs_to :guild
  
  validates_presence_of :what
  validates_length_of :what, :within => 3..40
  validates_length_of :where, :within => 0..255
  validates_length_of :description, :within => 0..512
  
  def date
    read_attribute :when
  end
  
  def to_param
    permalink
  end
end
