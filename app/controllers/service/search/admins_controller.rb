module Service
  module Search
    class AdminsController < BaseController
      def index
        @results = User.search_by_terms(params[:term], params[:page].presence || 1)
        render 'service/search/index'
      end
    end
  end
end
