Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users
      post "auth/signin", to: "users#login"
      resources :projects do
        get 'my_projects', on: :collection
      end  
    end
  end
end
