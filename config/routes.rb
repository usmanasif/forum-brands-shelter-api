Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :animals, except: %i(create destroy) do
        member do
          put :adopt
        end
      end
    end
  end
end
