require "test_helper"

class MoneyControllerTest < ActionDispatch::IntegrationTest
  test "it should error when currency is missing" do
    assert_raises Money::InvalidCurrencyError, "wrong currency" do
      get "/money", params: { amount: 100 }
    end
  end

  test "it calculates correctly usd to krw" do
    get "/money", params: { currency: "usd", amount: 100 }
    assert_response :success
    assert @response.body.include?("100.0 KRW is $0.06999999999999999 USD")

    refute_nil(@request.params[:currency])
  end

  test "it calculates correctly mxn to krw" do
    get "/money", params: { currency: "mxn", amount: 100 }
    assert_response :success
    assert @response.body.include?("100.0 KRW is $1.3 MXN")
  end

  test "it raises an error when currency is VALID but amount is not a number" do
    assert_raises ArgumentError, "can't convert nil into Float" do
      get "/money", params: { currency: "usd", amount: "babo" }
      assert_response :success
    end
  end
end
