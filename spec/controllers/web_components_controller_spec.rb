require 'spec_helper'

describe WebComponentsController do
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]

    @infoNewUser = {
        'provider' => 'github', 'uid' => '123456', 'info' => {'nickname' => 'toto', 'image'=> 'http://www.thisisahoster.com/dummy.png'}, 'credentials' => {'token'=>'ae123hsrui87qzrsdfthisispartofatest6e35c'}
    }

    #@user = User.from_omniauth(@infoNewUser)
    #puts @user.inspect

    #@user = @user

    #@infoNewWC = {
    #    name: 'Its a webcomponent',
    #    description: 'And this is amazing',
    #    githubLink: 'http://www.github.com/User/Repo.git',
    #    #imageLink: 'http://www.myhost.com/wc.png',
    #    author: 'User',
    #    submitter: @user
    #}
  end

  describe 'web components with paperclip' do

    it 'should create a web component with an image' do
      #Image.new :photo => File.new(Rails.root + 'public/missing/medium/missing.png')

    end

    it 'should create a web component with an image' do
      #post :create, @infoNewWC || {'auth_token' => @infoNewUser['credentials']['token'], 'type' => 'AngularJsWc'}

      User.all.each() do |u|
        puts u.name
      end


      #post :create, {:auth_token=> User.all.first().github_token, :type=> 'AngularJsWc',
      #               :web_component => {
      #                   :name=> 'Its a webcomponent',
      #                   :description=> 'And this is amazing',
      #                   :githubLink=> 'http://www.github.com/User/Repo.git',
      #                   :demoLink=> 'http://www.myhost.com/',
      #                   #:imageLink=> 'http://www.myhost.com/wc.png',
      #                   :author=> 'User',
      #                   #:submitter=> @user
      #                   :submitter=> User.all.first()
      #               }
      #}

      #post :create,  :type=> 'AngularJsWc', :web_component => {
      #    :name => @infoNewWC['name'],
      #    :description => @infoNewWC['description'],
      #    :githubLink => @infoNewWC['githubLink'],
      #    #:imageLink => @infoNewWC['imageLink'],
      #    :demoLink => @infoNewWC['demoLink'],
      #    :submitter => @user,
      #    :author => @infoNewWC['author']
      #}, :format => 'json', :auth_token => @user.github_token

      #puts response.body
      #expect(response).to be_success
    end
  end
end
