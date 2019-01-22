Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  api_version(:module => 'V1', :path => {:value => 'v1'}, :defaults => {:format => 'json'}, :default => true) do
    root 'movies#index'
  end
end
