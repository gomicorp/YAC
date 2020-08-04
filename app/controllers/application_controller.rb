class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_raven_context
  before_action :set_session_context

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

  def set_session_context
    #
  end

  def after_sign_in_path_for(resource)
    redirect_path_state = request.env.dig('omniauth.params', 'state').dup

    if redirect_path_state
      redirect_uri = URI(redirect_path_state)
      redirect_uri.fragment = 'yac-thread'
      redirect_uri.add_query(user: resource.id)

      redirect_uri.to_s
    else
      super(resource)
    end
  end

  def after_sign_out_path_for(resource)
    URI(request.referer).add_query(remove_user: 1).to_s || super(resource)
  end

  def alternative_authenticate_user!
    if params[:remove_user].present?
      sign_out User.find(params[:user_id])
    elsif !user_signed_in? && params[:user_id].present?
      sign_in User.find(params[:user_id])
    end
  end

  def default_url_options
    params[:user_id].present? ? super.merge(user_id: params[:user_id]) : super
  end
end
