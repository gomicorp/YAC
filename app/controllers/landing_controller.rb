class LandingController < ApplicationController
  layout 'landing'
  before_action :layout_false, only: %i[]

  def main
    #
  end

  def terms
    #
  end

  def privacy
    #
  end

  private

  def layout_false
    render layout: false
  end
end
