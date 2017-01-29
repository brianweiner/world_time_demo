Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'search_results#index'
  resources :search_results, only: [:create, :index]
  resources :users, only: [] do
    resources :search_results, only: :index, :controller => 'user/search_results'
  end

end
