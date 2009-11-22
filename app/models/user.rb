class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :guilds, :dependent => :destroy
  
  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
  
  before_create :standard_roles
  
  def standard_roles
    roles << Role.find_or_create_by_name('Author')
  end
  
  def role_symbols
    roles.map { |role| role.name.underscore.to_sym }
  end
  
end
