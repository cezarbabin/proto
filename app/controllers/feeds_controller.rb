class FeedsController < ApplicationController

  def index
    #show all announcements
    @post = Post.new

    @var = false;
    if (User.find(current_user).post_id != nil)
      @var = true;
    end

    @posts = Post.all
  end

end
