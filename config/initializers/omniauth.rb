Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  #TODO put me to config app
  if Rails.env.production?
    provider :github, '05aea2ceeb33fd2c75f8', '076fdd621ce0006460dfc78891c29185e2b47655', scope: 'user:email,user:follow'
  elsif Rails.env.development?
    provider :github, '05aea2ceeb33fd2c75f8', '076fdd621ce0006460dfc78891c29185e2b47655', scope: 'user:email,user:follow'
  end
  OmniAuth.config.logger = Rails.logger
end