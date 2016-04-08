Rails.application.routes.draw do
  get 'programs/create'

  get 'programs/index'

  get 'programs/edit'

  get 'programs/new'

  get 'programs/update'

  get 'programs/delete'

  resources :agencies
  resources :items
  resources :bin_items
  resources :bins
  resources :categories
  resources :carts
  resources :agencies

  get 'get_new_barcode' => 'items#get_new_barcode', as: :get_new_barcode
  post 'get_new_barcode' => 'items#get_new_item_info', as: :get_new_item_info

  get 'home' => 'home#home', as: :home

  # Named routes - Cart
  get 'add_to_cart/:id' => 'carts#add_to_cart', as: :add_to_cart
  get 'get_quantity_for_item/:id' => 'carts#get_quantity_for_item', as: :get_quantity_for_item
  post 'get_quantity_for_item/:id' => 'carts#add_item_and_quantity_to_cart', as: :add_item_and_quantity_to_cart

  get 'show_cart' => 'carts#show_cart', as: :show_cart
  get 'remove_item/:id' => 'carts#remove_item', as: :remove_item
  get 'clear' =>  'carts#clear', as: :clear_cart

  # Toggle Agency Status
  patch 'toggle_agency/:id' => 'agencies#toggle_agency', as: :toggle_agency


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

    # Set the root url
  root :to => 'home#home'  

  # Last route in routes.rb that essentially handles routing errors
  get '*a', to: 'errors#routing'
  
end
