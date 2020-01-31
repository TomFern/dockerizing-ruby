require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do

    # tutorial
    # get pages_home_url
    get "/"
    assert_response :success

  end

end
