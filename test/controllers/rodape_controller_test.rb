require 'test_helper'

class RodapeControllerTest < ActionController::TestCase
  test "should get rodape" do
    get :rodape
    assert_response :success
  end

end
