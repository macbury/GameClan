class Forum < ActiveRecord::Base
  has_many :topics, :dependent => :destroy
  belongs_to :guild
  xss_terminate
  
  validates_presence_of :name, :description
  validates_length_of :name, :within => 3..255
  validates_length_of :description, :within => 0..255
  
  has_permalink :name, :update => true
  
  def to_param
    permalink
  end
  
end
