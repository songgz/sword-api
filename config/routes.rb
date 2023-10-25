Rails.application.routes.draw do
  resources :menu_items

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :v1 do
    resources :cards
    resources :teachers
    resources :schools
    resources :menu_items
    resources :quizzes
    resources :words
    resources :units
    resources :books
    resources :auths do
      collection do
        post :login
        post :logout
      end
    end
    resources :students
    resources :auth do
      collection do
        post :sign_in
        post :logout
      end
    end
  end

end
