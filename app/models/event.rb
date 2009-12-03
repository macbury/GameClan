class Event < ActiveRecord::Base
  xss_terminate
  has_permalink :what, :update => true
  
  attr_protected :guild_id, :user_id
  
  belongs_to :user
  belongs_to :guild
  
  def to_param
    permalink
  end
end
