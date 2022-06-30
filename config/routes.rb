Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "users/signup", to: "users#create"
      post "auth/signin", to: "users#login"
      resources :projects do
        get 'my_projects', on: :collection
        resources :contents
      end  
    end
  end
end
