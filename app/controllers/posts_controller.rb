class PostsController < ApplicationController

  def index
    flash.now[:info] = 'You do not have a big enough network yet'
  end

  def create
    @user = current_user
    @post = @user.posts.create(post_params)
    if @post.save

      @user.update_attribute(:post_id, @post.id)
      flash[:info] = "now u done for the week"
      redirect_to :back
    else
      @feed_items = []
      redirect_to :back
    end
  end

  private
    def post_params
      params.require(:post).permit(:post, :title)
    end

end
