class LandingController < ApplicationController
  layout 'landing'

  def main
    render layout: false
  end
end
