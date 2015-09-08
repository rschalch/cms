require 'test_helper'

class DemoControllerTest < ActionController::TestCase
  test "should get text_helpers" do
    get :text_helpers
    assert_response :success
  end

end
