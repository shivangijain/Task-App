Rails.application.routes.draw do
  # mount Notifications::Engine => "/notifications"
  resources :posts
  root to:  "home#index"
  devise_for :users, :controllers => {
    registrations: 'users/registrations',
  }
  resources :friends, only: [:index, :show] do
    collection do
      get :suggestions
      get :requests
      post :add_friend
      post :accept_friend
      post :cancel_friend
      get :notification
    end
  end
  mount Commontator::Engine => '/commontator'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
