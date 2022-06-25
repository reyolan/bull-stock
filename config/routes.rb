Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: 'admins' do
    resources :pending_traders, only: %i[index destroy]
  end    

  root 'static_pages#home'
end
