class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_raven_context

  private

  def set_raven_context
    return unless %w[production].include?(Rails.env)

    # Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(
      params: params.to_unsafe_h,
      url: request.url,
      locale: I18n.locale,
      current_user: user_signed_in? ? current_user.as_json.symbolize_keys : nil
    )
  end

  def after_sign_in_path_for(resource)
    redirect_path_state = request.env.dig('omniauth.params', 'state')
    redirect_path_state&.gsub!('_=_', 'yac-thread')

    redirect_path_state || super(resource)
  end

  def after_sign_out_path_for(resource)
    request.referer || super(resource)
  end
end
