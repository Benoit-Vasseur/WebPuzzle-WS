class User < ActiveRecord::Base
  attr_accessible :uid, :name

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.name = auth['info']['nickname']
        user.avatar_url = auth['info']['image']
        user.github_token = auth.credentials.token
      end
  end
end
