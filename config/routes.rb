Rails.application.routes.draw do
  resources :users do
    resources :courses, only: [:create, :destroy]
  end
  resources :courses, excepct: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'pages#home'

  # RESTful Routes (generated by scaffold)

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'add_course/:user_id/:course_id', to: 'registrations#add_course'
  get 'drop_course/:user_id/:course_id', to: 'registrations#drop_course'
end
