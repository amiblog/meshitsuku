Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
  end


  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'homes/about'
    get "customers/unsubscribe" => "customers#unsubscribe"
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :recipes, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
