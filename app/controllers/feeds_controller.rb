class FeedsController < ApplicationController

  before_action :logged_in_user, only: [:show, :index, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]

  def index
    #show all announcements that are made for this user
    @post = Post.new

    @var = false;
    if (User.find(current_user).post_id != nil)
      @var = true;
    end

    @posts = Post.all
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

end
