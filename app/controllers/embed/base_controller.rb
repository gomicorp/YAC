module Embed
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token

    private

    def allow_valid_iframe
      response.headers.except! 'X-Frame-Options'
    end
  end
end
