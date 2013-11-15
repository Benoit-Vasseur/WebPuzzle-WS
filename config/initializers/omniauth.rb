Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  #TODO put me to config app
  if Rails.env.production?
    provider :github, '10fa7db1a43339bce9e4', 'c547630c5151b767b6c3e4e61f81101061468119', scope: 'user:email,user:follow'
  elsif Rails.env.development?
    provider :github, '05aea2ceeb33fd2c75f8', '076fdd621ce0006460dfc78891c29185e2b47655', scope: 'user:email,user:follow'
  end
  OmniAuth.config.logger = Rails.logger
end