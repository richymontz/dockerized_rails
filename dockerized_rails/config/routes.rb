Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  
  get 'web_sites', controller: :urls, action: :web_sites
  get '*page', controller: :urls, action: :get
  post 'create_url', controller: :urls, action: :create
end
