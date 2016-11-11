Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions, only: [:index, :new, :create, :show, :destroy]  do
    resources :answers, only: [:new, :create, :destroy]
  end

  root to: "questions#index"
end
