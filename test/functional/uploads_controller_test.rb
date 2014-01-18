require 'test_helper'

class UploadsControllerTest < ActionController::TestCase
  setup do
    @upload = uploads(:one)

    @infoNewUser = {
        'provider' => 'github', 'uid' => '123456', 'info' => {'nickname' => 'toto', 'image'=> 'http://www.thisisahoster.com/dummy.png'}, 'credentials' => {'token'=>'ae123hsrui87qzrsdfthisispartofatest6e35c'}
    }

    @user = users(:user1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uploads)
  end

  test "should get new" do
    assert_raises(ActionController::RoutingError){
      get :new
      assert_response :success
    }
  end

  test "should create upload" do
    assert_difference('Upload.count') do
      post :create, upload: { file_file_name: @upload.file_file_name }, auth_token: @user.github_token
    end

    assert_response 201
  end

  test "should show upload" do
    get :show, id: @upload
    assert_response :success
  end

  test "should get edit" do
    assert_raises(ActionController::RoutingError){
      get :edit, id: @upload
      assert_response :success
    }
  end

  test "should update upload" do
    assert_raises(ActionController::RoutingError){
      put :update, id: @upload, upload: { file_file_name: @upload.file_file_name }
      assert_response :success
    }
  end

  test "should destroy upload" do
    assert_raises(ActionController::RoutingError){
      assert_difference('Upload.count', -1) do
        delete :destroy, id: @upload
      end
    }
  end
end
