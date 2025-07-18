Rails.application.routes.draw do
  get "customers/dashboard"
  get "reviews/create"
  get "reviews/destroy"
  get "inventories/index"
  get "inventories/update"
  get "orders/index"
  get "orders/show"
  get "orders/create"
  # Home page
  root "products#index"

  # Health check for uptime monitoring
  get "up" => "rails/health#show", as: :rails_health_check

  # (Optional) PWA endpoints
  # get "manifest"         => "rails/pwa#manifest",        as: :pwa_manifest
  # get "service-worker"   => "rails/pwa#service_worker",  as: :pwa_service_worker

  # Authentication
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # Categories and Products
  resources :categories
  resources :products do
    # Nested reviews for products
    resources :reviews, only: [ :create, :destroy ]
  end

  # Inventory (admin only)
  resources :inventories, only: [ :index, :update ]

  # Customer orders
  resources :orders, only: [ :index, :show, :create ]

  # Staff/Admin order management
  namespace :staff do
    get "orders/index"
    get "orders/update"
    resources :orders, only: [ :index, :update ]
    get "/", to: "dashboard#index", as: :dashboard
  end

  # Admin dashboard
  draw(:admin) # Add this line to load admin routes
  # Customer dashboard
  get "customer/dashboard", to: "customers#dashboard", as: :customer_dashboard  # Session-based cart routes
  post   "cart/add/:product_id",      to: "carts#add_item",       as: :add_to_cart
  post   "cart/increase/:product_id", to: "carts#increase_item",  as: :increase_cart_item
  post   "cart/decrease/:product_id", to: "carts#decrease_item",  as: :decrease_cart_item
  delete "cart/remove/:product_id",   to: "carts#remove_item",    as: :remove_from_cart
  delete "cart/clear",                to: "carts#clear_cart",     as: :clear_cart
  get    "cart",                      to: "carts#show",           as: :cart
end
