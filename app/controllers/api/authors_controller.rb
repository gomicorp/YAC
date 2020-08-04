module Api
  class AuthorsController < BaseController
    before_action :set_author, only: :show

    def index
      @authors = @organization.authors
      # ...
    end

    def show
      # ...
    end

    private

    def set_author
      @author = @organization.authors.find(params[:id])
    end
  end
end
