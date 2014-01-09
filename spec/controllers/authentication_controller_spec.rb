require 'spec_helper'

describe AuthenticationController do
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  describe 'github authentication' do

    it 'should redirect to omniauth handler' do
      get :send_authentication, :provider=> 'github'
      response.should redirect_to '/auth/github'
    end

    it 'should handle github callback' do

    end
  end
end
