class ApplicationController < ActionController::Base
  include Pagy::Backend

  def after_sign_in_path_for(resource)
    request.env.dig('omniauth.params', 'state') || super(resource)
  end

  def after_sign_out_path_for(resource)
    request.referer || super(resource)
  end
end
