require 'test_helper'

class WebComponentsControllerTest < ActionController::TestCase

  setup do
    @infoNewUser = {
        'provider' => 'github', 'uid' => '123456', 'info' => {'nickname' => 'toto', 'image'=> 'http://www.thisisahoster.com/dummy.png'}, 'credentials' => {'token'=>'ae123hsrui87qzrsdfthisispartofatest6e35c'}
    }

    #@user = User.from_omniauth(@infoNewUser)
    @user = users(:user1)

    @infoNewWC = {
        'name' => 'Its a webcomponent',
        'description'=> 'And this is amazing',
        'githubLink'=> 'http://www.github.com/User/Repo.git',
        'demoLink'=> 'http://www.myhost.com/wc.png',
        'author'=> 'User',
        'submitter' => @user,
    }

    @web_component = web_components(:wc1)

    @worlds = %w['AngularJsWc','AngularDartWc','JqueryWc','EmberWc','PolymerJsWc','PolymerDartWc']
  end

  #/**************************** Errors expected **************************************/
  test 'should not get index of an unknown world' do
    get :index, :format => 'json'

    assert_response 500

    message = ActiveSupport::JSON.decode(@response.body)
    assert_equal 'You must provide a valid type of web component.', message['error_message']
  end

  test 'should not destroy a web component (for now)' do
    delete :destroy, id:@web_component, :format =>'json', :auth_token => @user.github_token

    assert_response 500

    message = ActiveSupport::JSON.decode(@response.body)
    assert_equal 'Deletion is not implemented yet.', message['error_message']
  end

  test 'should not create a web component without token' do
    post :create, :type=> 'AngularJsWc', :web_component => {
        :name => @infoNewWC['name'],
        :description => @infoNewWC['description'],
        :githubLink => @infoNewWC['githubLink'],
        #:imageLink => @infoNewWC['imageLink'],
        :demoLink => @infoNewWC['demoLink'],
        :submitter => @user,
        :author => @infoNewWC['author']
    }, :format => 'json'

    assert_response 500

    message = ActiveSupport::JSON.decode(@response.body)
    assert_equal 'You must provide a valid token to execute this request. See manual for further information.', message['error_message']
  end

  #/**************************** Global **************************************/
  test 'should show a web component by its id' do
    get :show, id: @web_component, :format => 'json'

    assert_response 200
  end

  #/**************************** AngularJsWc ********************************/
  test 'should create a AngularJsWc web component' do
    assert_difference ->{ AngularJsWc.all.count }, 1 do
      post :create,  :type=> 'AngularJsWc', :web_component => {
          :name => @infoNewWC['name'],
          :description => @infoNewWC['description'],
          :githubLink => @infoNewWC['githubLink'],
          #:imageLink => @infoNewWC['imageLink'],
          :demoLink => @infoNewWC['demoLink'],
          :submitter => @user,
          :author => @infoNewWC['author']
      }, :format => 'json', :auth_token => @user.github_token
    end

    assert_response 201

    wc = ActiveSupport::JSON.decode(@response.body)
    assert_equal @user.id, wc['submitter']['id']
  end

  test 'should get index for world AngularJsWc' do
    get :index, :type => 'AngularJsWc' , :format => 'json'

    assert_response 200
    assert_not_nil assigns(:web_components)
  end

  test 'should update a AngularJsWc web component' do
    put :update, id: @web_component, :web_component => {
        :name => @web_component.name + '-AngularJsWc',
        :description => @web_component.description + '-AngularJsWc',
        :githubLink => @web_component.githubLink,
        #:imageLink => @web_component.imageLink,
        :demoLink => @infoNewWC['demoLink'],
        :submitter => @user
    }, :format => 'json', :auth_token => @user.github_token

    assert_response 204

    get :show, id: @web_component, :format => 'json'
    assert_response 200

    resp = ActiveSupport::JSON.decode(@response.body)
    assert_equal @web_component.name + '-AngularJsWc', resp['name']
    assert_equal @web_component.description + '-AngularJsWc', resp['description']
  end

  #/**************************** AngularDartWc *******************************/
  test 'should create a AngularDartWc web component' do
    assert_difference -> { AngularDartWc.all.count }, 1 do
      post :create,  :type=> 'AngularDartWc', :web_component => {
          :name => @infoNewWC['name'],
          :description => @infoNewWC['description'],
          :githubLink => @infoNewWC['githubLink'],
          #:imageLink => @infoNewWC['imageLink'],
          #:submitter => @infoNewWC['submitter'],
          :demoLink => @infoNewWC['demoLink'],
          :submitter => @user,
          :author => @infoNewWC['author']
      }, :format => 'json', :auth_token => @user.github_token
    end

    assert_response 201

    wc = ActiveSupport::JSON.decode(@response.body)
    assert_equal @user.id, wc['submitter']['id']
  end

  test 'should get index for world AngularDartWc' do
    get :index, :type => 'AngularDartWc' , :format => 'json'

    assert_response 200
    assert_not_nil assigns(:web_components)
  end

  test 'should update a AngularDartWc web component' do
    put :update, id: @web_component, :web_component => {
        :name => @web_component.name + '-AngularDartWc',
        :description => @web_component.description + '-AngularDartWc',
        :githubLink => @web_component.githubLink,
        :demoLink => @infoNewWC['demoLink'],
        #:imageLink => @web_component.imageLink,
        :submitter => @user
    }, :format => 'json', :auth_token => @user.github_token

    assert_response 204

    get :show, id: @web_component, :format => 'json'
    assert_response 200

    resp = ActiveSupport::JSON.decode(@response.body)
    assert_equal @web_component.name + '-AngularDartWc', resp['name']
    assert_equal @web_component.description + '-AngularDartWc', resp['description']
  end

  #/**************************** JqueryWc *******************************/
  test 'should create a JqueryWc web component' do
    assert_difference ->{ JqueryWc.all.count }, 1 do
      post :create,  :type=> 'JqueryWc', :web_component => {
          :name => @infoNewWC['name'],
          :description => @infoNewWC['description'],
          :githubLink => @infoNewWC['githubLink'],
          #:imageLink => @infoNewWC['imageLink'],
          :demoLink => @infoNewWC['demoLink'],
          :submitter => @infoNewWC['submitter'],
          :author => @infoNewWC['author']
      }, :format => 'json', :auth_token => @user.github_token
    end

    assert_response 201

    wc = ActiveSupport::JSON.decode(@response.body)
    assert_equal @user.id, wc['submitter']['id']
  end

  test 'should get index for world JqueryWc' do
    get :index, :type => 'JqueryWc' , :format => 'json'

    assert_response 200
    assert_not_nil assigns(:web_components)
  end

  test 'should update a JqueryWc web component' do
    put :update, id: @web_component, :web_component => {
        :name => @web_component.name + '-JqueryWc',
        :description => @web_component.description + '-JqueryWc',
        :githubLink => @web_component.githubLink,
        :demoLink => @infoNewWC['demoLink'],
        #:imageLink => @web_component.imageLink,
        :submitter => @user
    }, :format => 'json', :auth_token => @user.github_token

    assert_response 204

    get :show, id: @web_component, :format => 'json'
    assert_response 200

    resp = ActiveSupport::JSON.decode(@response.body)
    assert_equal @web_component.name + '-JqueryWc', resp['name']
    assert_equal @web_component.description + '-JqueryWc', resp['description']
  end

  #/**************************** EmberWc *******************************/
  test 'should create a EmberWc web component' do
    assert_difference ->{ EmberWc.all.count }, 1 do
      post :create,  :type=> 'EmberWc', :web_component => {
          :name => @infoNewWC['name'],
          :description => @infoNewWC['description'],
          :githubLink => @infoNewWC['githubLink'],
          #:imageLink => @infoNewWC['imageLink'],
          :demoLink => @infoNewWC['demoLink'],
          :submitter => @infoNewWC['submitter'],
          :author => @infoNewWC['author']
      }, :format => 'json', :auth_token => @user.github_token
    end

    assert_response 201

    wc = ActiveSupport::JSON.decode(@response.body)
    assert_equal @user.id, wc['submitter']['id']
  end

  test 'should get index for world EmberWc' do
    get :index, :type => 'EmberWc' , :format => 'json'

    assert_response 200
    assert_not_nil assigns(:web_components)
  end

  test 'should update a EmberWc web component' do
    put :update, id: @web_component, :web_component => {
        :name => @web_component.name + '-EmberWc',
        :description => @web_component.description + '-EmberWc',
        :githubLink => @web_component.githubLink,
        :demoLink => @infoNewWC['demoLink'],
        #:imageLink => @web_component.imageLink,
        :submitter => @user
    }, :format => 'json', :auth_token => @user.github_token

    assert_response 204

    get :show, id: @web_component, :format => 'json'
    assert_response 200

    resp = ActiveSupport::JSON.decode(@response.body)
    assert_equal @web_component.name + '-EmberWc', resp['name']
    assert_equal @web_component.description + '-EmberWc', resp['description']
  end

  #/**************************** PolymerJsWc *******************************/
  test 'should create a PolymerJsWc web component' do
    assert_difference ->{ PolymerJsWc.all.count }, 1 do
      post :create,  :type=> 'PolymerJsWc', :web_component => {
          :name => @infoNewWC['name'],
          :description => @infoNewWC['description'],
          :githubLink => @infoNewWC['githubLink'],
          #:imageLink => @infoNewWC['imageLink'],
          :demoLink => @infoNewWC['demoLink'],
          :submitter => @infoNewWC['submitter'],
          :author => @infoNewWC['author']
      }, :format => 'json', :auth_token => @user.github_token
    end

    assert_response 201

    wc = ActiveSupport::JSON.decode(@response.body)
    assert_equal @user.id, wc['submitter']['id']
  end

  test 'should get index for world PolymerJsWc' do
    get :index, :type => 'PolymerJsWc' , :format => 'json'

    assert_response 200
    assert_not_nil assigns(:web_components)
  end

  test 'should update a PolymerJsWc web component' do
    put :update, id: @web_component, :web_component => {
        :name => @web_component.name + '-PolymerJsWc',
        :description => @web_component.description + '-PolymerJsWc',
        :githubLink => @web_component.githubLink,
        :demoLink => @infoNewWC['demoLink'],
        #:imageLink => @web_component.imageLink,
        :submitter => @user
    }, :format => 'json', :auth_token => @user.github_token

    assert_response 204

    get :show, id: @web_component, :format => 'json'
    assert_response 200

    resp = ActiveSupport::JSON.decode(@response.body)
    assert_equal @web_component.name + '-PolymerJsWc', resp['name']
    assert_equal @web_component.description + '-PolymerJsWc', resp['description']
  end

  #/**************************** PolymerDartWc *******************************/
  test 'should create a PolymerDartWc web component' do
    assert_difference ->{ PolymerDartWc.all.count }, 1 do
      post :create,  :type=> 'PolymerDartWc', :web_component => {
          :name => @infoNewWC['name'],
          :description => @infoNewWC['description'],
          :githubLink => @infoNewWC['githubLink'],
          #:imageLink => @infoNewWC['imageLink'],
          :demoLink => @infoNewWC['demoLink'],
          :submitter => @infoNewWC['submitter'],
          :author => @infoNewWC['author']
      }, :format => 'json', :auth_token => @user.github_token
    end

    assert_response 201

    wc = ActiveSupport::JSON.decode(@response.body)
    assert_equal @user.id, wc['submitter']['id']
  end

  test 'should get index for world PolymerDartWc' do
    get :index, :type => 'PolymerDartWc' , :format => 'json'

    assert_response 200
    assert_not_nil assigns(:web_components)
  end

  test 'should update a PolymerDartWc web component' do
    put :update, id: @web_component, :web_component => {
        :name => @web_component.name + '-PolymerDartWc',
        :description => @web_component.description + '-PolymerDartWc',
        :githubLink => @web_component.githubLink,
        :demoLink => @infoNewWC['demoLink'],
        #:imageLink => @web_component.imageLink,
        :submitter => @user
    }, :format => 'json', :auth_token => @user.github_token

    assert_response 204

    get :show, id: @web_component, :format => 'json'
    assert_response 200

    resp = ActiveSupport::JSON.decode(@response.body)
    assert_equal @web_component.name + '-PolymerDartWc', resp['name']
    assert_equal @web_component.description + '-PolymerDartWc', resp['description']
  end

  #/***************************************************************************/
end
