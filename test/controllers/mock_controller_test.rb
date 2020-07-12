require 'test_helper'

class MockControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mock_index_url
    assert_response :success
  end

end
