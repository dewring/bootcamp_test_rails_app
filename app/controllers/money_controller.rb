# WORKS
# http://localhost:3000/money?currency=usd&amount=100
# ERROR
# http://localhost:3000/money
class MoneyController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_user_with_token!
  
  def exchange
    @currency = params[:currency]
    @amount = Float(params[:amount])

    money_calculator = Money.new(@currency)
    @result = money_calculator.krw_to_other(@amount)

    respond_to do |format|
      # 1. Renders index.html.erb by default
      format.html do
        render(:exchange)
      end

      # 2. Returns JSON data directly
      format.json do
        variable_balbla = 3
        render json: {
          this_data_only_for_json: variable_balbla,
          currency: @currency,
          amount: @amount,
          result: @result
        }
      end
    end
  end
end
