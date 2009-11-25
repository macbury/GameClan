class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  
  xss_terminate
  has_permalink :title, :update => true
  
  validates_presence_of :title, :body
  validates_length_of :title, :within => 3..80
  validates_length_of :body, :within => 3..10000
  
  def to_param
    permalink
  end
  
end
