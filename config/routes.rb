Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :customers, only: [:index, :show, :destroy]
    resources :recipes, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get "customers/unsubscribe" => "customers#unsubscribe"
    resources :customers, only: [:index, :show, :edit, :update, :destroy] do
      member do
        get 'favorites'
      end
      collection do
        get 'search'
      end
    end
    resources :recipes, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      collection do
        get 'search'
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
