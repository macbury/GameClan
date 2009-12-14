class Photo < ActiveRecord::Base
	belongs_to :user
	belongs_to :guild
	
	xss_terminate

	attr_protected :user_id, :guild_id

	has_attached_file :image, :styles => { :small => "130x97#", :preview => "560x420#", :forum => "320x240#" },
                    :url => "/guild_assets/photos/:style/:id.:extension",
                    :path => ":rails_root/public/guild_assets/photos/:style/:id.:extension"

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png'], :message => "nieprawidłowy format pliku"
  validates_attachment_size :image, :less_than => 1.megabyte
  validates_attachment_presence :image
	
	after_create :mail_notification
	
	def mail_notification
		#BackgroundWorker.new.deliver_photo_notification(:photo_id => self.id)
		BackgroundWorker.asynch_deliver_photo_notification(:photo_id => self.id)
	end
	
	def url(size=nil)
		image.url(size)
	end

end
