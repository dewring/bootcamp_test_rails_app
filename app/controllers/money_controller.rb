class MoneyController < ApplicationController
  def exchange
    @currency = params[:currency]
    @amount = params[:amount].to_f

    money_calculator = Money.new(@currency)
    @result = money_calculator.krw_to_other(@amount)
  end
end
