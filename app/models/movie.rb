class Movie < ActiveRecord::Base
  xss_terminate
  has_permalink :title, :update => true
  
  validates_presence_of :title, :description
  validates_length_of :title, :within => 3..50
  validates_length_of :description, :within => 3..1024
  
  belongs_to :user
  belongs_to :guild
  
  has_attached_file :clip,
                    :path => ":rails_root/tmp/videos/input/:id.:extension"
  validates_attachment_presence :clip
  validates_attachment_size :clip, :less_than => 100.megabytes
  validates_attachment_content_type :clip, :content_type => ['video/3gpp', 'video/3gpp2', '3gpp-tt', 'video/mp4', 'video/quicktime', 'video/wmv', 'video/mpeg', 'video/x-msvideo']
  
  has_attached_file :video,
                    :url  => "/guild_assets/videos/:id.:extension",
                    :path => ":rails_root/public/guild_assets/videos/:id.:extension"
  
  has_attached_file :preview, :styles => { :small => "120x90#" },
                    :url => "/guild_assets/videos/previews/:style/:id.:extension",
                    :path => ":rails_root/public/guild_assets/videos/previews/:style/:id.:extension"
  
  after_create :process_clip
  
  attr_protected :user_id
  
  def process_clip
    MovieWorker.asynch_convert(:movie_id => self.id)
  end
  
  def to_param
    permalink
  end
  
end
