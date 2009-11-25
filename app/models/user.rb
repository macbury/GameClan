class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :guilds, :dependent => :destroy
  
  has_many :memberships, :dependent => :destroy
  has_many :guild_member, :through => :memberships, :source => :guild, :conditions => ['accepted = ?', true]
  
  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
  has_many :topics, :dependent => :destroy
  
  def role_symbols
    roles.map { |role| role.name.underscore.to_sym }
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
