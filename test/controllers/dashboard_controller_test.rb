require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get admininstrator" do
    get :admininstrator
    assert_response :success
  end

end
