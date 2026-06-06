Rails.application.routes.draw do
  devise_for :users
  # /money 주소로 들어오면 money_controller의 exchange 액션으로 가라는 뜻입니다.
  get "/money", to: "money#exchange"
  get "/testing_erb", to: "pages#erb"
  resources :teachers
  resources :school_classes
  resources :students
  resources :student_registrations, controller: "registrations"

  root to: "students#index"
end
