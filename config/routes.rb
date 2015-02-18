Rails.application.routes.draw do

  resources :flyers do
    member do
      get :personalize
      get :send_email
    end
  end
  resources :plans
  resources :subscriptions

  get 'admin', to: 'admin/dashboards#index'
  get 'generate/subscription'
  get 'dispatcher/start'
  get 'dispatcher/pages_user_profile'
  get 'dispatcher/send'

  devise_for :users

  namespace :admin do
    resources :static_pages
    resources :templates
    resources :plans
    resources :users
    resources :realtors
  end

  ['welcome', 'coverage_and_pricing', 'create_a_flyer',
   'how_it_works', 'about_us', 'faq', 'contact_us'].each do
    |method|
    if method == 'welcome'
      root "static_pages##{method}"  
    else
      get "/#{method}", to: "static_pages##{method}"        
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
