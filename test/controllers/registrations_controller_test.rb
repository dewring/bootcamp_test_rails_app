require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "index html displays registrations" do
    get "/registrations"
    assert_response :success
    assert @response.body.include?("registrations")
  end

  test "index returns registrations as json array" do
    get "/registrations.json"
    assert_response :success

    json = JSON.parse(@response.body)
    assert_equal 80, json.first["point"]
    assert_equal 10, json.last["booster"]
  end

  test "show html loads successfully" do
    registration = Registration.first
    get "/registrations/#{registration.id}"
    assert_response :success
  end

  test "show returns correct registration json data" do
    registration = Registration.first
    get "/registrations/#{registration.id}.json"
    assert_response :success

    json = JSON.parse(@response.body)
    # assert_equal registration.id, json["id"]
    assert_equal 80, json["point"]
    assert_equal 20, json["booster"]
    assert_equal "Chiikawa", json["student_name"]
    assert_equal "being cute", json["subject"]
  end
end
