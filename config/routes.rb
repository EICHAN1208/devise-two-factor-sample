Rails.application.routes.draw do
  get 'two_step_verifications/new'
  post 'two_step_verifications', to: 'two_step_verifications#create'
  delete 'two_step_verifications', to: 'two_step_verifications#destroy'

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations',
    omniauth_callbacks: 'auth/omniauth_callbacks'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
