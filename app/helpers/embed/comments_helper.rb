module Embed
  module CommentsHelper
    # include HelperComponent::Factory

    def comment_component
      @comment_component ||= CommentComponent.new(self)
    end


    class CommentComponent < HelperComponent
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
    end
  end
end
