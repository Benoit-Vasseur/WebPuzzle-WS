class AuthenticationController < ApplicationController
  def github_callback
    #Récupération des informations de l'utilisateur
    user = User.from_omniauth(env['omniauth.auth'])
    redirect_to session['authentication']['target'] + '?auth_token=' + user.github_token.to_s
  end

  def send_authentication
    #Vérification de la source de l'appel, normalement la demande d'authentification vient du front WebPuzzle (adresse à modifier dans le fichier config/config.yml)
    if request.referer != APP_CONFIG['webpuzzle_front']
      raise Exceptions::CustomException.new I18n.t 'security.referer'
    end

    #L'adresse de retour doit être spécifiée (normalement doit appartenir au domaine WebPuzzle, à rajouter)
    if !params[:target].present?
      raise Exceptions::CustomException.new I18n.t 'authentication.target'
    end

    if params[:provider] == 'github'
      session['authentication'] = {'target' => params[:target]}
    end

    redirect_to '/auth/' + params[:provider]
  end

  def failure
    #redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
    raise Exceptions::CustomException.new params[:message].humanize
  end
end
