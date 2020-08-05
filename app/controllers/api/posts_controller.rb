module Api
  class PostsController < BaseController
    def index
      @posts = @site.posts
    end

    def show
      @post = @site.posts.find(params[:id])
    end
  end
end
