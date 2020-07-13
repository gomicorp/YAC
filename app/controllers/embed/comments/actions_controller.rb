module Embed
  module Comments
    class ActionsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_comment
      before_action :check_authorized_user
      layout 'embeded'

      def hide
        @comment.update!(hide_at: now)
      end

      def display
        @comment.update!(hide_at: nil)
      end


      private

      def set_comment
        @comment = Comment.find(params[:id])
        @post = @comment.post
        @site = @post.site
        @organization = @site.organization
      end

      def check_authorized_user
        return render status: :forbidden unless author_or_admin
      end

      def author_or_admin
        current_user.id == @comment.author_id || current_user.admin_of?(@organization)
      end

      def now
        Time.zone.now.in_time_zone.to_datetime
      end
    end
  end
end
