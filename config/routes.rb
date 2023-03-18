Rails.application.routes.draw do
  root :to =>"homes#top"

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
    resources :products, only: [:index, :new, :show, :edit, :update]
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
    resources :carts, only: [:index, :update, :destroy, :create] 
    delete "/carts/destroy_all" => "carts#destroy_all"
  end

end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
