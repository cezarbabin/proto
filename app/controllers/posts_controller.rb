class PostsController < ApplicationController

  def index
    flash.now[:info] = 'You do not have a big enough network yet'
  end

end
