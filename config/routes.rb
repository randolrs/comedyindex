Rails.application.routes.draw do

  resources :location_prompts
  resources :markets
  resources :show_reviews
  resources :shows
  resources :venues
  #resources :show_occurrences
  resources :performers
  devise_for :users, controllers: {registrations: 'registrations'}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  root 'pages#home'

  get 'signup' => 'pages#signup'

  get 'dashboard' => 'users#dashboard'

  get 'comedian_contact_form' => 'pages#comedian_contact_form'

  get 'login' => 'pages#login'

  get 'community' => 'pages#community'

  get 'account' => 'users#account_settings'

  get 'update_city_link' => 'pages#update_city_link', as: 'update_city_link'

  post 'update_market' => 'pages#update_market', as: 'update_market'

  post 'update_city' => 'pages#update_city', as: 'update_city'

  post 'comedian_contact_submit' => 'pages#comedian_contact_submit', as: 'comedian_contact_submit'



  get 'search' => 'pages#search', as: 'search'

  get '/:market_name' => 'pages#search', as: 'city_search'


  get 'profile/setup' => 'performers#setup_profile', as: 'setup_performer_profile'

  

  get 'signup/comics' => 'users#comic_signup', as: 'comic_signup'

  get 'signup/producers' => 'users#producer_signup', as: 'producer_signup'

  get 'signup/venues' => 'users#venue_signup', as: 'venue_signup'

  get 'shows/comedy/:market_name' => 'shows#dashboard', as: 'show_dashboard'

  get 'writeareview' => 'shows#index_for_review', as: 'index_for_review'

  
  #get ':city/:url_slug/' => 'shows#show_home', as: 'show_home'

  get 'show/:id/occurrences/' => 'shows#this_shows_occurrences', as: 'this_shows_occurrences'

  get 'show/occurrence/edit/:id' => 'shows#edit_show_occurrence', as: 'edit_a_show_occurrence'

  patch 'show/occurrence/update/:id' => 'shows#update_show_occurrence', as: 'update_show_occurrence'


  get ':city/comedy/:url_slug/:formatted_date/:show_occurrence_id' => 'shows#show_with_url', as: 'show_with_url'



  get 'v/:url_slug' => 'venues#show_with_url', as: 'venue_with_url'

  get '/category/:url_slug' => 'pages#show_tag_index', as: 'home_tag_index'

  get ':market_name/category/:url_slug' => 'shows#show_tag_index', as: 'show_tag_index'

  get 'u/:display_name' => 'users#profile', as: 'user_profile'

  get 'review/new/:show_id' => 'show_reviews#new_with_show_header', as: 'new_review'

  get '/show/vote/:showID/:direction', :to => 'users#vote'
  

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
