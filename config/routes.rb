Rails.application.routes.draw do
  resources :statistics
  resources :menu_items

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :v1 do
    resources :words
    resources :statistics do
      collection do
        get :week
        get :month
        get :year
        get :notebook
      end
    end
    resources :learned_units
    resources :users do
      collection do
        post :recovery_password
      end
    end
    resources :supervised_students
    resources :learnable_books
    resources :learned_books
    resources :cards do
      collection do
        post :multi_create
      end
    end
    resources :teachers do
      collection do
        post :supervise
      end
    end
    resources :schools
    resources :menu_items
    resources :quizzes
    resources :dictionaries
    resources :units
    resources :books
    resources :auths do
      collection do
        post :login
        post :logout
      end
    end
    resources :students do
      collection do
        post :multi_create
        post :recharge
      end
    end
    resources :auths do
      collection do
        post :sign_in
        post :logout
        post :change_password
      end
    end
  end

end
