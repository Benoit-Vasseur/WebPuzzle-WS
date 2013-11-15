require 'httparty'
require 'net/http'

class AuthenticationController < ApplicationController
  include HTTParty
  #http_proxy '195.83.230.3', 3128
  base_uri APP_CONFIG['github_api_v3']


  def github_callback
    #Récupération des informations de l'utilisateur
    user = User.from_omniauth(env['omniauth.auth'])

    redirect_to APP_CONFIG['webpuzzle_front'] + APP_CONFIG['webpuzzle_front_auth_end'] + user.github_token.to_s
  end

  def send_authentication
    #Vérification de la source de l'appel, normalement la demande d'authentification vient du front WebPuzzle (adresse à modifier dans le fichier config/config.yml)
    #if request.referer != APP_CONFIG['webpuzzle_front']
    #  raise Exceptions::CustomException.new I18n.t 'security.referer'
    #end

    redirect_to '/auth/' + params[:provider]
  end

  def check_token
    puts params.inspect
    if !params[:access_token].present?
        raise Exceptions::CustomException.new I18n.t 'authentication.notoken'
    end

    if !correct_token?(params[:access_token])
        raise Exceptions::CustomException.new(I18n.t('authentication.notoken'))
    end

    if params[:provider] == 'github'
      result = self.class.get('/user', :query => {'access_token' => params[:access_token].to_s})

      raise Exceptions::CustomException.new(I18n.t('generic.unknownerror')) if result.response.code != '200'

      render json:result, status:result.response.code
    end
  end

  def failure
    #redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
    raise Exceptions::CustomException.new params[:message].humanize
  end
end
