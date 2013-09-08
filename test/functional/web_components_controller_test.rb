require 'test_helper'

class WebComponentsControllerTest < ActionController::TestCase
  setup do
    @web_component = web_components(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:web_components)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create web_component" do
    assert_difference('WebComponent.count') do
      post :create, web_component: {  }
    end

    assert_redirected_to web_component_path(assigns(:web_component))
  end

  test "should show web_component" do
    get :show, id: @web_component
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @web_component
    assert_response :success
  end

  test "should update web_component" do
    put :update, id: @web_component, web_component: {  }
    assert_redirected_to web_component_path(assigns(:web_component))
  end

  test "should destroy web_component" do
    assert_difference('WebComponent.count', -1) do
      delete :destroy, id: @web_component
    end

    assert_redirected_to web_components_path
  end
end
