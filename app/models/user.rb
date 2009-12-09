class User < ActiveRecord::Base
  acts_as_authentic
  xss_terminate
  
  has_attached_file :avatar, :styles => { :logo => "200x200#", :forum => "48x48#", :large => "500x500>" }, :processors => [:cropper]
  validates_attachment_size :avatar, :less_than => 500.kilobytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
  
	attr_protected :roles, :assignments
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :terms_of_service

  has_many :guilds, :dependent => :destroy
  
  has_many :memberships, :dependent => :destroy
  has_many :guild_member, :through => :memberships, :source => :guild, :conditions => ['accepted = ?', true]
  
  has_many :moderatorships, :dependent => :destroy
  has_many :moderated_guilds, :class_name => "Guild", :source => :guild, :through => :moderatorships
  
  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  
  has_many :movies, :dependent => :destroy
  has_many :events, :dependent => :destroy
	has_many :photos, :dependent => :destroy  
  #validates_length_of :full_name, :within => 0..255
  #validates_length_of :www, :within => 0..255
  validates_format_of :www, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates_acceptance_of :terms_of_service, :on => :create

  after_update :reprocess_avatar, :if => :cropping?
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
  def role_symbols
    roles.map { |role| role.name.underscore.to_sym }
  end
  
  def total_posts
    p = posts_count || 0
    t = topics_count || 0
    p + t
  end
  
  def isGuildMember?(guild)
    !self.memberships.first(:conditions => { :guild_id => guild.id, :accepted => true }).nil?
  end
  
  def assign_role(role_name)
    role = Role.find_or_create_by_name(role_name)
    assignments.find_or_create_by_role_id(role.id)
  end
  
  def to_param
    login
  end
  
  private
    
    def reprocess_avatar
      avatar.reprocess!
    end
end
