class PostsController < ApplicationController
  before_filter :login_required, :load_resources
  
  filter_access_to [:create, :new], :attribute_check => true, 
                                    :load_method => lambda { @post = @topic.posts.new(params[:post]) }
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @post = @topic.posts.find(params[:id]) }
                          
  def create
    @post.user = self.current_user
    @topic.replied_by = self.current_user
    @topic.save
    if @post.save
      flash[:notice] = "Dodano odpowiedź do dyskusji"
      redirect_to [@guild, @forum, @topic]
    else
      render :action => 'edit'
    end
  end
  
  def edit
    
  end
  
  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = "Zapisano zmiany"
      redirect_to [@guild, @forum, @topic]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @post.destroy
    flash[:notice] = "Usunięto post"
    redirect_to [@guild, @forum, @topic]
  end
  
  protected
    
    def load_resources
      @guild = Guild.find_by_permalink!(params[:guild_id])
      @forum = @guild.forums.find_by_permalink!(params[:forum_id])
      @topic = @forum.topics.find_by_permalink!(params[:topic_id])
			@title = ["Forum", @forum.name]
    end
end
