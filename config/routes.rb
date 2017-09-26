Rails.application.routes.draw do
  resources :markers
  root to: 'markers#index'
end
