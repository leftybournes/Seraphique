Rails.application.routes.draw do
    devise_for :administrators,
               controllers: {
                   sessions: "administrators/sessions",
                   registrations: "administrators/registrations"
    }

    devise_for :users,
               controllers: {
                   sessions: "users/sessions",
                   registrations: "users/registrations"
    }
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check

    # Defines the root path route ("/")
    # root "posts#index"
    root to: "home#index"

    get "/about", to: "about#index"
    resources :products

    resources :shopping_cart_items

    post "/shopping_cart_items/:user_id/:product_id",
         to: "shopping_cart_items#new_shopping_cart_item_for_user",
         as: :new_shopping_cart_item_for_user
end
