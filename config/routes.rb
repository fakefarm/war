Rails.application.routes.draw do
  namespace :v1 do
    # curl  "http://localhost:3001/v1/combat?p1=hulk&p2=thor&seed_number=3"
    get 'combat', to: 'combat#index'
    resources :apidocs, only: [:index]
  end

  root to: 'v1/apidocs#index'
end
