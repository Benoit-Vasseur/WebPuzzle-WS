require Rails.root.join('config/environments/development')

WebPuzzleWs::Application.configure do
  AWS.config(:proxy_uri => 'https://proxy.ig2i.fr:3128')
end
