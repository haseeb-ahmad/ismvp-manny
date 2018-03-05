Rails.application.routes.draw do

  get "users/disconnect" => "users#disconnect"
  devise_for :users, :controllers => { :confirmations => "confirmations",
                                       :registrations => "registrations",
                                       :omniauth_callbacks => "omniauth_callbacks",
                                       :sessions => "sessions"
                                    }

  devise_scope :user do
    patch "/confirm" => "confirmations#confirm"
  end

  resources :users, :only => :none do
    get "connections"
    collection do
      get :dashboard
      get :browser_knows
      get :browser_knows_list
      get :account
      post :fetch_yodlee_data
      get :yodlee_data
      get :track_motion
    end
    get "update_contacts"
    resources :contacts do
      resources :notes
    end
  end

  resources :twillio_confirmations, only: [:new, :create] do
    collection do
      get 'check_number', as: :check_number
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  root :to => "home#index"

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
