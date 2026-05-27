Rails.application.routes.draw do
  # /money 주소로 들어오면 money_controller의 exchange 액션으로 가라는 뜻입니다.
  get "/money", to: "money#exchange"
end
