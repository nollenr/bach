require 'test_helper'

class MasterLibraryFileControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
