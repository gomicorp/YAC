module Api
  class SitesController < BaseController
    skip_before_action :set_site, only: :index

    def index
      @sites = @organization.sites
      # raise :test
    end

    def show
      # @site = @organization.sites.find(params[:domain])
    end
  end
end
