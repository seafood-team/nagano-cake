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
    


    end
    
   scope module: :public do
   resources :products, only: [:index, :show]
 end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
