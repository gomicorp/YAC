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
    # redirect_path_state&.gsub!('_=_', "yac-thread?user=#{resource.id}")
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
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    ap request.referer
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

    URI(request.referer).add_query(remove_user: 1).to_s || super(resource)
  end
end
