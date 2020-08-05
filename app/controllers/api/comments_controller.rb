module Api
  class CommentsController < BaseController
    def index
      @comments = @site.comments

      @comments = @comments.where(author_id: params[:author_id]) if params[:author_id]
      @comments = @comments.where(post_id: params[:post_id]) if params[:post_id]
    end

    def show
      @comment = @site.comments.find(params[:id])
    end
  end
end
