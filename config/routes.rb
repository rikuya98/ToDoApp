Rails.application.routes.draw do
  devise_for :users
  devise_for :models

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    get '/'=> 'boards#index'
    resource :profile, only: [:show, :edit, :update]
    resources :boards do
      resources :tasks do
        resources :comments
      end
   end
end
