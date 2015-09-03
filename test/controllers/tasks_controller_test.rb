require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get all" do
    get :all
    assert_response :success
  end

end
