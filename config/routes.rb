Rails.application.routes.draw do
  # /money 주소로 들어오면 money_controller의 exchange 액션으로 가라는 뜻입니다.
  get "/money", to: "money#exchange"
  get "/students", to: "students#index"
  get "/students/:id", to: "students#show"
  get "/testing_erb", to: "pages#erb"
  resources :teachers, only: [ :index, :show ]
  resources :school_classes, only: [ :index, :show ]
  resources :students, only: [ :index, :show ]
  resources :registrations, only: [ :index, :show ]
end
