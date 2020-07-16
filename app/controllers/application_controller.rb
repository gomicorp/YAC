class ApplicationController < ActionController::Base
  include Pagy::Backend

  def after_sign_in_path_for(resource)
    redirect_path_state = request.env.dig('omniauth.params', 'state')
    redirect_path_state&.gsub!('_=_', 'yac-thread')

    redirect_path_state || super(resource)
  end

  def after_sign_out_path_for(resource)
    request.referer || super(resource)
  end
end
