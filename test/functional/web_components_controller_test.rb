require 'test_helper'

class WebComponentsControllerTest < ActionController::TestCase
  setup do
    @web_component = WebComponent.all.first()

    module Token
      def token
        'ae123hsrui87qzrsdfthisispartofatest6e35c'
      end
    end

    module Credentials
      def credentials
         self.extend Token
      end
    end

    info = {
        'provider' => 'github', 'uid' => '123456', 'info' => {'nickname' => 'toto', 'image'=> 'http://www.thisisahoster.com/dummy.png'}
    }
    info.extend Credentials

    @user = User.from_omniauth(info)
  end

  test 'should get index' do
    get :index, :format => 'json'
    assert_response :success
    assert_not_nil assigns(:web_components)
  end

  test 'should get new' do
    get :new, :format => 'json'
    assert_response :success
  end

  test 'should show a web comonent' do
    get :show, id: @web_component, :format => 'json'
    assert_response :success
  end

  test 'should update a web component' do
    put :update, id: @web_component, :web_component => {
        :name => 'Second name',
        :description => @web_component.description,
        :githubLink => @web_component.githubLink,
        :imageLink => @web_component.imageLink,
        :submitter => @web_component.submitter
    }, :format => 'json', :auth_token => @user.github_token
    assert_response 204
  end

  test 'should destroy a web component' do
    assert_difference 'WebComponent.count', -1 do
      delete :destroy, id:@web_component, :format =>'json', :auth_token => @user.github_token
    end
    assert_response 204
  end

  test 'should create a web component' do
    assert_difference 'WebComponent.count', 1 do
      post :create,  :web_component => {
          :name => 'Second name',
          :description => @web_component.description,
          :githubLink => @web_component.githubLink,
          :imageLink => @web_component.imageLink,
          :submitter => @web_component.submitter,
      }, :format => 'json', :auth_token => @user.github_token
    end
    assert_response 201
  end

  test 'should not create a web component' do
    assert_raise ActiveModel::MassAssignmentSecurity::Error do
      post :create,  :web_component => {
          :error => 'I am not a right web component'  # error is not an attribute of a web component
      }, :format => 'json', :auth_token => @user.github_token
    end
  end

  test 'should not create a web component without token' do
      post :create,  :web_component => {
          :name => 'Second name',
          :description => @web_component.description,
          :githubLink => @web_component.githubLink,
          :imageLink => @web_component.imageLink,
          :submitter => @web_component.submitter,
      }, :format => 'json'
      assert_response 500
  end
end
