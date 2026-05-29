class Money
  class InvalidCurrencyError < StandardError
  end

  class InvalidAmountError < StandardError
  end

  def initialize(input_currency)
    if input_currency == "cad" || input_currency == "mxn" || input_currency == "usd" || input_currency == "euro"
      @currency = input_currency
    else
      raise InvalidCurrencyError, "wrong currency"
    end
  end

  def krw_to_other(krw)
    if krw.is_a?(Numeric) == false
      raise InvalidAmountError, "wrong number"
    end

    if @currency == "cad"
      krw * 0.001
    elsif @currency == "mxn"
      krw * 0.013
    elsif @currency == "usd"
      krw * 0.0007
    elsif @currency == "euro"
      krw * 0.00057
    end
  end

  def current_currency
    @currency
  end
end
