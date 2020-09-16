module Service
  class CommentsController < SiteScopedController
    before_action :set_scoped_collection
    before_action :set_comment, only: %i[show edit update destroy]

    # GET /service/sites/1/comments
    # GET /service/sites/1/comments.json
    # POST /service/sites/1/comments/search
    # POST /service/sites/1/comments/search.json
    def index
      @search_query_object = {}
      @search_query_object[:post_id] = params[:post_id] if params[:post_id].present?
      @comments = @comments.where(@search_query_object)

      @search = @comments.ransack(params[:q])
      @search.sorts = 'id desc'
      @pagy, @comments = pagy(@search.result(distinct: true))
      @search.build_condition
    end

    # GET /service/sites/1/comments/1
    # GET /service/sites/1/comments/1.json
    def show
    end

    # GET /service/sites/1/comments/new
    def new
      @comment = @comments.new
    end

    # GET /service/sites/1/comments/1/edit
    def edit
    end

    # POST /service/sites/1/comments
    # POST /service/sites/1/comments.json
    def create
      @comment = @comments.new(comment_params)

      respond_to do |format|
        if @comment.save
          format.html { redirect_to after_create_path, notice: 'Comment was successfully created.' }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /service/sites/1/comments/1
    # PATCH/PUT /service/sites/1/comments/1.json
    def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to after_update_path, notice: 'Comment was successfully updated.' }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /service/sites/1/comments/1
    # DELETE /service/sites/1/comments/1.json
    def destroy
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to after_destroy_path, notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end


    private

    def set_scoped_collection
      @comments = @site.comments.includes(:post, author: :identities).all.with_rich_text_content_and_embeds
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:rating, :hide_at, :remote_ip, :post_id, :author_id)
    end

    def after_default_path
      site_comments_path(@site.id)
    end

    def default_collection_path
      site_comments_path(@site.id)
    end

    alias after_create_path after_default_path
    alias after_update_path after_default_path
    alias after_destroy_path default_collection_path
  end
end
