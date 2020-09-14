module Service
  class SiteScopedController < BaseController
    before_action :set_common_resources

    private

    def set_common_resources
      @site = Site.find(params[:site_id])
      @organization = @site.organization
    end
  end
end
