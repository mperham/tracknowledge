ActionController::Routing::Routes.draw do |map|
  map.connect 'products/:category', :controller => 'products', :action => 'index'

  # The priority is based upon order of creation: first created -> highest priority.
  map.resource :session, :member => { :logout => :get }
  map.resource :home, :member => { :legal => :get, :about_us => :get }
  map.resource :search
  map.resources :tracks, :collection => { :random => :get }
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  map.namespace :admin do |admin|
    admin.resources :tracks, :active_scaffold => true, :member => { :approve => :get }
  end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'homes'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:sort_key/:sort_order'
end
