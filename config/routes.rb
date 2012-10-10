Ylsite::Application.routes.draw do

  #devise_for :users, :skip => [:registrations]
  devise_for :users
  as :user do
    post "users" => "users#create"
  end

  match 'test' => 'page_customs#test'


  match 'pay/arrive/:invoice/:reply' => 'payments#arrive'
  match 'pay/callback/:invoice/:sum/:currency/:reply/:id/:mac' => 'payments#callback'
  match 'pay/now' => 'payments#pay'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :reservations
  resources :invoices
  resources :customers
  resources :boats
  resources :payments

  root :to => 'welcome#index'

  namespace :principal do
    resources :boat_reservation
  end

  namespace :api do
  	namespace :v1 do
  		#match 'supplier_marinas' => 'supplier_marina#index'
      match 'version' => 'api#version'
      match 'environment' => 'api#environment'
      
  		resources :supplier_marinas, :only => [:new, :create] do
  			collection do
  				get 'list' => 'supplier_marinas#list'
  			end
  		end
  		
      resources :principals, :only => [:create] do
        collection do
          get 'list' => 'principals#list'
        end
      end
      
      resources :boat_avail_prices do
      	collection do
      		get 'list' => 'boat_avail_prices#list'
      	end
      end
      
      resources :boat_attributes do
      	collection do
      		get 'list' => 'boat_attributes#list'
      	end
      end
      
      resources :boats, :only => [:create] do
        collection do
          get 'list' => 'boats#list'
        end
      end
      
      resources :boat_pictures, :only => [:create] do
        collection do
          get 'list' => 'boat_pictures#list'
        end
      end
  	end
  end

  resources :marinas, :only => [] do
    collection do
      get 'autocomplete' => 'marinas#autocomplete'
    end
  end
  
  match 'reserve-:permalink/date-:from-to-:to' => 'customers#new', :as => 'new_customer_with_date'
  match 'yachts/(:destination)/people.(:people)/pickup.(:pickup)/return.(:return)' => 'yacht_search#search'
  match 'yachts' => 'yacht_search#search_proxy'
  match 'yacht-:permalink/' => 'boats#show', :as => 'show_yacht'
  match 'yacht-:permalink/date-:from-to-:to' => 'boats#show', :as => 'show_with_date_yacht'
  match '/trips/:identifier' => 'reservations#show', :as => 'trip'
  match 'your-reservation' => 'reservations#index'

  # should be last, map any remaining urls as custom non-application urls
  match ':url', :controller => 'page_customs', :action => 'show'
  
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
