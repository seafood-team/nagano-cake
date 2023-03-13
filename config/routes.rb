Rails.application.routes.draw do
  
  get 'admin/index'
  get 'admin/show'
  get 'admin/edit'
  get 'admin/update'
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  resources :customers, only: [:show, :create, :edit, :update] do
    member do
    patch "withdraw"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
