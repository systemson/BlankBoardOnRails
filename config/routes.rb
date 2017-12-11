Rails.application.routes.draw do

  namespace :admin do
    # Home
    get '/', to: 'dashboard#index', as: 'home'

    # Dashboard
    get '/dashboard', to: 'dashboard#index', as: 'dashboard'

    # Access
    resources :users
    resources :roles, :except => [:show]
    resources :permissions, :only => [:index, :edit, :update]

    ##
    # Email
    ##

    # Emails resource
    resources :emails

    # Emails folders
    get 'sent_emails/', to: 'emails#sent', as: 'sent_emails'
    get 'draft_emails/', to: 'emails#draft', as: 'draft_emails'
    get 'trashed_emails/', to: 'emails#trash', as: 'trash_emails'

  end

  # Auth
  get 'login/', to: 'auth/login#login', as: 'login'
  post 'logout/', to: 'auth/login#logout', as: 'logout'
  get 'register/', to: 'auth/login#register', as: 'register'
  post 'auth/', to: 'auth/login#auth'

  root 'front/home#index', as: 'home'

  get 'home/', to: 'front/home#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
