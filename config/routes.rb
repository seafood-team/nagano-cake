Rails.application.routes.draw do
  root :to =>"homes#top"
  get "/about" => "homes#about"

  devise_for :admin, controllers: {
    sessions:      'admin/sessions',
    passwords:     'admin/passwords',
  }
  devise_for :customers, controllers: {
    sessions:      'public/sessions',
    passwords:     'public/passwords',
    registrations: 'public/registrations'
  }

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    get "/" => "homes#top"
    get "orders/customer" => "orders#customer"
    resources :orders, only: [:show, :update, :index, :customer]
    resources :order_details, only: [:update]
    resources :products, only: [:index, :new, :show, :create, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    get "admin/search" => "products#search"
  end


  scope module: :public do
    resource :customers, only: [:show, :update, :edit]
    get "/customers/unsubscribe" => "customers#unsubscribe"
    get "/customers/withdraw" => "customers#withdraw"
    resources :products, only: [:index, :show]
    resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:new ,:index , :create, :show]
    post 'order/check' => 'orders#check'
    get 'order/thanks' => 'orders#thanks'
    delete "/carts/destroy_all" => "carts#destroy_all"
    resources :carts, only: [:index, :update, :destroy, :create] 
    get "/search" => "products#search"
  end

end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
