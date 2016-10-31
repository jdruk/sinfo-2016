require 'test_helper'

class CertificateControllerTest < ActionController::TestCase
  test "should get create_certificate" do
    get :create_certificate
    assert_response :success
  end

end
