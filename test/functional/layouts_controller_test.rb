require 'test_helper'

class LayoutsControllerTest < ActionController::TestCase
  setup do
    @layout = layouts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:layouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create layout" do
    assert_difference('Layout.count') do
      post :create, :layout => @layout.attributes
    end

    assert_redirected_to layout_path(assigns(:layout))
  end

  test "should show layout" do
    get :show, :id => @layout.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @layout.to_param
    assert_response :success
  end

  test "should update layout" do
    put :update, :id => @layout.to_param, :layout => @layout.attributes
    assert_redirected_to layout_path(assigns(:layout))
  end

  test "should destroy layout" do
    assert_difference('Layout.count', -1) do
      delete :destroy, :id => @layout.to_param
    end

    assert_redirected_to layouts_path
  end
end
