Rails.application.routes.draw do
  root 'needs#index'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  devise_scope :user do
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount RedactorRails::Engine => '/redactor_rails'

  devise_for :donors, :controllers => { :omniauth_callbacks => "donors/omniauth_callbacks" }

  resources :messages

  resources :organizations

  resources :donations

  resources :needs

  resources :donors

  resources :users

  get 'pages/terms'
end
