Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  api_version(:module => 'V1', :path => {:value => 'v1'}, :defaults => {:format => 'json'}, :default => true) do
    root 'movies#index'

    get :upcoming,       to: 'movies#upcoming'
    get :premiere,       to: 'movies#premiere'
    get :reprojection,   to: 'movies#reprojection'

    resources :movies,    only: [:index, :show]
    resources :cinemas,   only: [:index, :show]
    resources :showtimes, only: :show
  end
end
