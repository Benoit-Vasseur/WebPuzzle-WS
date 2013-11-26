require 'test_helper'

class WebComponentsControllerTest < ActionController::TestCase

  setup do
    #@web_component = WebComponent.all.first()
    @infoNewUser = {
        'provider' => 'github', 'uid' => '123456', 'info' => {'nickname' => 'toto', 'image'=> 'http://www.thisisahoster.com/dummy.png'}, 'credentials' => {'token'=>'ae123hsrui87qzrsdfthisispartofatest6e35c'}
    }
    #
    @user = User.from_omniauth(@infoNewUser)
    #

    #@user = users(:user1)
    @infoNewWC = {
        'name' => 'Its a webcomponent',
        'description'=> 'And this is amazing',
        'githubLink'=> 'http://www.github.com/User/Repo.git',
        'imageLink'=> 'http://www.myhost.com/wc.png',
        'author'=> 'User',
        'submitter' => @user,
    }

    #@web_component = WebComponent.create(@infoNewWC)

    #@user = Us
    @web_component = web_components(:wc1)
  end


  test 'should create a web component' do
    assert_difference 'WebComponent.count', 1 do
      post :create,  :web_component => {
          :name => @infoNewWC['name'],
          :description => @infoNewWC['description'],
          :githubLink => @infoNewWC['githubLink'],
          :imageLink => @infoNewWC['imageLink'],
          :submitter => @infoNewWC['submitter'],
          :author => @infoNewWC['author']
      }, :format => 'json', :auth_token => @infoNewUser['credentials']['token']
    end
    assert_response 201

    wc = ActiveSupport::JSON.decode(@response.body)
    assert_equal @user.id, wc['submitter']['id']
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
        :name => @web_component.name,
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

  test 'should not create a web component' do
    assert_raise ActiveModel::MassAssignmentSecurity::Error do
      post :create,  :web_component => {
          :error => 'I am not a right web component'  # error is not an attribute of a web component
      }, :format => 'json', :auth_token => @user.github_token
    end
  end

  test 'should not create a web component without token' do
      post :create,  :web_component => {
          :name => @web_component.name,
          :description => @web_component.description,
          :githubLink => @web_component.githubLink,
          :imageLink => @web_component.imageLink,
          :submitter => @web_component.submitter,
          :author => @web_component.author
      }, :format => 'json'
      assert_response 500
  end
end
