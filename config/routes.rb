WebPuzzleWs::Application.routes.draw do
  scope :format => true do
    get '/web_components/:type', to: 'web_components#index'
    get '/web_component/:id', to: 'web_components#show'
    post '/web_component/:type', to: 'web_components#create'
    put '/web_component/:id', to: 'web_components#update'
    delete '/web_component/:id', to: 'web_components#destroy'
  end

  resources :uploads

  match '*path', :controller => 'application', :action => 'empty', :constraints => {:method => "OPTIONS"}
  resources :web_components

  get '/auth/:provider/send', to: 'authentication#send_authentication'
  get '/auth/:provider/callback', to: 'authentication#github_callback'
  get '/auth/:provider/check', to: 'authentication#check_token'
  get '/auth/failure', to: 'sessions#failure'
  get '/', to: 'web_components#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'web_components#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
