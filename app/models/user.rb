class User < ActiveRecord::Base
  acts_as_authentic
  xss_terminate
  
  has_attached_file :avatar, :styles => { :logo => "200x200>", :forum => "48x48>" }
  validates_attachment_size :avatar, :less_than => 500.kilobytes
  
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
  
  has_many :guilds, :dependent => :destroy
  
  has_many :memberships, :dependent => :destroy
  has_many :guild_member, :through => :memberships, :source => :guild, :conditions => ['accepted = ?', true]
  
  has_many :moderatorships, :dependent => :destroy
  has_many :moderated_guilds, :class_name => "Guild", :source => :guild, :through => :moderatorships
  
  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  
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
  
end
