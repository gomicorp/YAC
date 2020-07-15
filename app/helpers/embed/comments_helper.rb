module Embed
  module CommentsHelper
    # include HelperComponent::Factory

    def comment_component
      @comment_component ||= CommentComponent.new(self)
    end

    def i_can_comment(comments)
      if user_signed_in?
        # 내가 작선한 글이 아직 없거나
        comments.where(author_id: current_user.id).empty? ||
          # 반복 작성이 가능하게 설정된 사이트일 때.
          comments.first.post.site.setting.comment_repeatable
      else
        true
      end
    end

    def i_can_reply
      user_signed_in?
    end

    def i_can_make_hide(comment)
      user_signed_in? && current_user.id == comment.author_id
    end

    def hide_toggle_path(comment)
      if comment.displayed?
        hide_embed_comment_path(comment, format: :js)
      else
        display_embed_comment_path(comment, format: :js)
      end
    end


    class CommentComponent < ::HelperComponent
      def main_nav(**opts)
        render 'embed/comments/components/main-nav', **opts
      end

      def alert(**opts)
        render 'embed/comments/components/alert', **opts
      end

      def footer(**opts)
        render 'embed/comments/components/footer', **opts
      end

      def form(**opts)
        render 'embed/comments/components/form', **opts
      end

      def avatar(**opts)
        render 'embed/comments/components/avatar', **opts
      end

      def comments(collection)
        render partial: 'embed/comments/components/comment', collection: collection, as: :comment
      end

      def action_link_to_if(condition, name, option = nil, html_options = nil, &block)
        render(
          'embed/comments/components/action-link',
          condition: condition,
          name: name,
          option: option,
          html_options: html_options,
          block: block
        )
      end
    end
  end
end
