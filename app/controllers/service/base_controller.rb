module Service
  class BaseController < ApplicationController
    before_action :should_sign_in!
    layout 'service'

    def should_sign_in!
      redirect_to new_user_session_path unless user_signed_in?
    end
  end
end
