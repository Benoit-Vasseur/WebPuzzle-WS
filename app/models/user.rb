class User < ActiveRecord::Base
  attr_accessible :name, :avatar_url, :github_token, :provider, :uid


  def self.extract_info(auth)
    {'provider'=>auth['provider'], 'uid'=>auth['uid'], 'name'=>auth['info']['nickname'], 'avatar_url'=>auth['info']['image'], 'github_token'=>auth['credentials']['token']}
  end

  def self.from_omniauth(auth)
    auth_info = self.extract_info(auth)

    #Recherche selon le provider et l'uid de l'utilisateur représentant l'id de l'utilisateur chez le provider
    user = self.where(auth.slice('provider', 'uid')).first
    #Si l'utilisateur s'est déjà connecté et est déjà enregistré, on vérifie s'il y a des mises à jour à faire
    if user
      if user.attributes.except('id', 'created_at', 'updated_at') != auth_info
        #Les informations ont changees
        user.update_attributes! auth_info
      end
    else
      #creation dun utilisateur
      user = self.create_from_omniauth(auth)
    end

    user
  end

  def self.create_from_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.name = auth['info']['nickname']
        user.avatar_url = auth['info']['image']
        user.github_token = auth['credentials']['token']
      end
  end
end
