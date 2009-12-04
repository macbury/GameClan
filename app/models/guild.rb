class Guild < ActiveRecord::Base
  has_permalink :name, :update => true
  xss_terminate
  using_access_control
  
  validates_presence_of :name, :server, :game, :background_color
  validates_length_of :name, :within => 3..34
  validates_length_of :server, :within => 3..255
  validates_length_of :game, :within => 3..255
  validates_length_of :about, :maximum => 512
  validates_length_of :guild_join_text, :within => 3..512
    
  validates_uniqueness_of :name
  validates_format_of :background_color, :with => /[a-fA-F0-9]{1,6}/i
  
  attr_protected :permalink, :user_id
  
  attr_accessor :theme
  
  has_many :memberships, :dependent => :destroy
  has_many :members, :through => :memberships, :source => :user, :conditions => [' memberships.accepted = ? ', true]
  has_many :all_members, :through => :memberships, :source => :user
  
  has_many :moderatorships, :dependent => :destroy
  has_many :moderators, :through => :moderatorships, :source => :user
  
  has_many :movies, :dependent => :destroy
  has_many :events, :dependent => :destroy  
  
  has_many :forums, :dependent => :destroy
  has_many :topics, :through => :forums
  
  belongs_to :user
  belongs_to :master, :class_name => "User", :foreign_key => "user_id"
  
  has_attached_file :background, :styles => { :thumb => "100x100>" },
                    :url  => "/guild_assets/backgrounds/:style/:id.:extension",
                    :path => ":rails_root/public/guild_assets/backgrounds/:style/:id.:extension"

  #validates_attachment_presence :background
  validates_attachment_size :background, :less_than => 1.megabytes
  validates_attachment_content_type :background, :content_type => ['image/jpeg', 'image/png']
  
  has_attached_file :logo, :styles => { :original => "200x200>" },
                    :url  => "/guild_assets/logos/:id.:extension",
                    :path => ":rails_root/public/guild_assets/logos/:id.:extension"

  #validates_attachment_presence :logo
  validates_attachment_size :logo, :less_than => 1.megabytes
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
  
  before_save :set_theme
  after_create :join_guild
  
  def join_guild
    member = Membership.find_or_initialize_by_user_id_and_guild_id(self.user_id, self.id)
    member.save(false)
    member.accept!(false)

    self.user.assign_role('Guild-Master')
  end
  
  def assign_moderator(user)
    moderatorships.find_or_create_by_user_id(user.id)
    user.assign_role("Guild-Moderator")
  end
  
  def isGuildMaster?(user)
    self.user.id == user.id
  end
  
  def isGuildModerator(user)
    !self.moderators.find(user.id).nil?
  end
  
  def set_theme
    return if self.theme.nil?

    theme = THEMES[self.theme.gsub('-',' ').titleize]
    
    if theme.class == Hash
      self.background_color = theme['background_color']
      self.background =  File.open("#{RAILS_ROOT}/public/guild_assets/backgrounds/themes/#{theme['background_image']}")
    end
    
  end
  
  def to_param
    permalink
  end

  
end
