authorization do
  role :admin do
    has_permission_on [:guilds, :members, :topic, :posts, :users, :moderatorships], :to => :act_as_god
    has_permission_on :authorization_rules, :to => :read
  end
  
  role :guest do
    has_permission_on [:guilds, :members, :forums, :topics, :posts], :to => :view
    has_permission_on [:memberships, :members], :to => [:new, :create]
    has_permission_on :guilds, :to => [:new, :create]
    
    has_permission_on :users, :to => [:index, :show, :new, :create]
    has_permission_on :users, :to => :change do
      if_attribute :id => is { user.id }
    end
    #has_permission_on :comments, :to => [:new, :create]
    #has_permission_on :comments, :to => [:edit, :update] do
    #  if_attribute :user => is { user }
    #end
  end
  
  role :guild_master do
    includes :guest
    
    has_permission_on :moderatorships, :to => [:create, :destroy] do
      if_attribute :master => is { user }
    end
    
    has_permission_on :guilds, :to => :change do
      if_attribute :master => is { user }
    end
    
    has_permission_on :forums, :to => :manage_all do
      if_attribute :guild => { :master => is { user } }
    end
    
    has_permission_on :topics, :to => :manage_all do
      if_attribute :forum => { :guild => { :master => is { user } } }
    end
    
    has_permission_on :posts, :to => :manage_all do
      if_attribute :topic => { :forum => { :guild => { :master => is { user } } } }
    end
    
    has_permission_on :members, :to => [:accept,:edit, :update, :delete, :destroy, :reason, :leave] do
      if_attribute :master => is { user }
    end

    has_permission_on [:memberships, :members], :to => [:accept, :not_accept, :edit, :update, :delete, :destroy] do
      if_attribute :guild => { :master => is { user } }
    end
  end
  
  role :guild_member do
    includes :guest
    
    #:guild => { :memberships => contains { user } }
    has_permission_on [:topics, :posts], :to => [:new, :create, :show]
    has_permission_on [:topics, :posts], :to => :change do
      if_attribute :user => is { user }
    end
    has_permission_on :members, :to => :leave
  end
  
  role :guild_moderator do
    includes :guest
    
    has_permission_on :topics, :to => :moderate do
      if_attribute :forum => { :guild => { :moderators => contains { user } } }
    end
    
    has_permission_on :posts, :to => :moderate do
      if_attribute :topic => { :forum => { :guild => { :moderators => contains { user } } } }
    end
    #has_permission_on :guilds, :to => [:edit, :update]
  end

end

privileges do
  privilege :change do
    includes :edit, :update, :delete, :destroy
  end
  
  privilege :moderate do
    includes :edit, :update, :delete, :destroy
  end
  
  privilege :view do
    includes :index, :show
  end
  
  privilege :act_as_god do
    includes :all
  end
  
  privilege :manage_all do
    includes :create, :new, :index, :show, :edit, :update, :delete, :destroy
  end
end