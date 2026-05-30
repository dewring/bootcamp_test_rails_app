require "test_helper"

class MoneyTest < ActiveSupport::TestCase
  test "#initialize currency is valid" do
    usd_money = Money.new("usd")
    mxn_money = Money.new("mxn")
    cad_money = Money.new("cad")
    euro_money = Money.new("euro")

    assert_equal("usd", usd_money.current_currency)
    assert_equal("mxn", mxn_money.current_currency)
    assert_equal("cad", cad_money.current_currency)
    assert_equal("euro", euro_money.current_currency)
  end
  test "#initialize raises error with invalid currency" do
    assert_raises Money::InvalidCurrencyError, "wrong currency" do
      Money.new("lira")
    end
  end

  test "#krw_to_other ensure krw is a number" do
    assert_raises Money::InvalidAmountError, "krw should be number" do
      usd_money = Money.new("usd")
      usd_money.krw_to_other("not a number")
    end
  end

  test "#krw_to_other ensure currency conversion is correct" do
    mxn_money = Money.new("mxn")
    assert_equal(mxn_money.krw_to_other(1000), 13)
    usd_money = Money.new("usd")
    assert_equal(usd_money.krw_to_other(1000), 0.7)
    cad_money = Money.new("cad")
    assert_equal(cad_money.krw_to_other(1000), 1)
    euro_money = Money.new("euro")
    assert_equal(euro_money.krw_to_other(10000000), 5700)
  end

  test "#current_currency returns the current currency" do
    mxn_money = Money.new("mxn")
    assert_equal("mxn", mxn_money.current_currency)
  end
end
