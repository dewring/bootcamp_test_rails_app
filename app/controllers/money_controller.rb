# WORKS
# http://localhost:3000/money?currency=usd&amount=100
# ERROR
# http://localhost:3000/money
class MoneyController < ApplicationController
  def exchange
    @currency = params[:currency]
    @amount = Float(params[:amount])

    money_calculator = Money.new(@currency)
    @result = money_calculator.krw_to_other(@amount)
  end
end
