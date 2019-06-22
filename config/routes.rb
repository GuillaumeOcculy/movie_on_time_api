Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  api_version(:module => 'V1', :path => {:value => 'v1'}, :defaults => {:format => 'json'}, :default => true) do

    root 'movies#index'

    post :auth,           to: 'authentication#create'

    get :search,         to: 'movies#search'
    get :upcoming,       to: 'movies#upcoming'
    get :premiere,       to: 'movies#premiere'
    get :reprojection,   to: 'movies#reprojection'

    resources :users,     only: :create
    resources :movies,    only: [:index, :show]

    resource :watchlist,  only: [:show, :create, :destroy]
    resources :watched_movies,  only: [:index, :create, :destroy]
    resources :favorite_cinemas,  only: [:index, :create, :destroy]

    resources :cinemas,   only: [:index, :show]
    resources :showtimes, only: :show
  end
end
