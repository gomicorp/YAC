module Mock
  class PostsController < ApplicationController
    before_action :set_organization
    before_action :set_site
    layout 'mock'

    def index
      @posts = Post.all
    end

    def show
      @post = Post.find(params[:id])
    end

    private

    def set_organization
      @organization = Organization.first
    end

    def set_site
      @site = @organization.sites.find_or_create_by domain: request.host
    end
  end
end
