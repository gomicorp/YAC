module Api
  class BaseController < ActionController::API
    before_action :set_organization
    before_action :set_site

    rescue_from ActiveRecord::RecordNotFound do
      render json: { message: 'Not Found' }, status: :not_found
    end

    private

    def set_organization
      @organization = Organization.find(params[:api_key])
    end

    def set_site
      @site = @organization.sites.find(params[:domain])
    end
  end
end
