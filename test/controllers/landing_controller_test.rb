require 'test_helper'

class LandingControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get landing_main_url
    assert_response :success
  end

end
