class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :guild
  
  xss_terminate
  
  validates_length_of :reason, :within => 3..1024, :on => :create
  validates_length_of :game_nick, :within => 0..32, :on => :create
  validates_format_of :stats_link, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/i, :on => :create
  
  attr_protected :user_id, :guild_id, :accepted
  
	after_create :mail_notification
	
	def mail_notification
		#BackgroundWorker.new.deliver_new_membership_notification(:membership_id => self.id)
		BackgroundWorker.asynch_deliver_new_membership_notification(:membership_id => self.id)
	end

  def accept!(clean=true)    
		Mailer.deliver_guild_accept(self) unless clean
    self.accepted = true
    save
    self.user.assign_role('Guild-Member')
  end
  
  def game_nick
    nick = read_attribute(:game_nick)
    nick = self.user.login if nick.nil? || nick.empty?
    
    return nick
  end
  
end
