module Embed
  class CommentsController < BaseController
    # skip_before_action :verify_authenticity_token, except: %i[create]
    prepend_before_action :alternative_authenticate_user!
    before_action :set_ancestors, except: %i[sdk index]
    after_action :allow_valid_iframe, only: :index

    layout 'embeded'

    def sdk
      allow_valid_iframe
      @admin_access = true if params[:admin].presence
      set_ancestors if @admin_access
      render layout: false
    end

    # GET /embed/comments?api_key=&domain=&identifier=
    # GET /embed/posts/:post_id/comments
    # GET /embed/posts/:post_id/comments.js
    def index
      if params[:post_id].present?
        # 1. To pagination
        set_ancestors
      else
        # For general CommentSDK
        set_valid_ancestors
      end

      @post.locations.visit!(params[:location].presence) if visitable?
      @setting = @post.site.setting

      comments = if user_signed_in? && @organization.admins.where(id: current_user.id).exists?
                   @post.comments.service_admin_scope
                 else
                   @post.comments.service_scope
                 end

      @pagy, @comments = pagy(comments, items: 10)
    end

    # => NOT USE
    # GET  /embed/posts/1/comments/1
    # GET  /embed/posts/1/comments/1.json
    def show
    end

    # => NOT USE
    # GET  /embed/posts/1/comments/new
    def new
      @comment = Comment.new
    end

    # => NOT USE
    # GET  /embed/posts/1/comments/1/edit
    def edit
    end

    # POST /embed/comments.js
    def create
      ap current_user
      @comment = @post.comments.new(comment_params.merge(
        remote_ip: request.remote_ip
      ))

      @comment.save!
      redirect_to request.referer
    end

    # PATCH/PUT  /embed/posts/1/comments/1
    # PATCH/PUT  /embed/posts/1/comments/1.json
    def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE  /embed/posts/1/comments/1
    # DELETE  /embed/posts/1/comments/1.json
    def destroy
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end


    private

    def allow_valid_iframe
      response.headers.except! 'X-Frame-Options'
    end

    def set_valid_ancestors
      @organization = Organization.find(params[:api_key])
      @site = permitted_site
      @post = @site.posts.find_or_create_by!(identifier: params[:identifier])
    end

    def set_ancestors
      @post = Post.find(params[:post_id])
      @site = @post.site
      @organization = @site.organization
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :author_id, :rating)
    end


    protected

    def permitted_site
      if any_site_permitted_api_key
        @organization.sites.find_or_create_by!(domain: params[:domain])
      else
        @organization.sites.find(params[:domain])
      end
    end

    def any_site_permitted_api_key
      Rails.env.development?
    end

    def visitable?
      location = params[:location].presence
      return false unless location
      return false if URI.parse(location).path.start_with? '/admin'

      true
    end
  end
end
