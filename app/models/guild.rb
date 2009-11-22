class Guild < ActiveRecord::Base
  has_permalink :name, :update => true
  xss_terminate
  
  validates_presence_of :name, :server, :game, :background_color
  validates_length_of :name, :within => 3..34
  validates_length_of :server, :within => 3..255
  validates_length_of :game, :within => 3..255
  validates_length_of :about, :maximum => 512
  
  validates_uniqueness_of :name
  validates_format_of :background_color, :with => /[a-fA-F0-9]{1,6}/i
  
  attr_protected :permalink, :user_id
  
  attr_accessor :theme
  
  belongs_to :user
  
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

  
  def type_name
    self.typ == GT_CLAN ? 'klanie' : 'gildii'
  end
  
end
