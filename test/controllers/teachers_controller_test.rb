require "test_helper"

class TeachersControllerTest < ActionDispatch::IntegrationTest
  def sign_in_as_user
    user = User.create!(email: "test@test.com", password: "password")
    sign_in user
  end
  test "index html displays teachers" do
    sign_in_as_user
    get "/teachers"
    assert_response :success
    assert @response.body.include?("teachers")
  end

  test "index returns teachers as json" do
    user = User.create!(email: "test@test.com", password: "password")
    get "/teachers.json", headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response :success
  end

  test "show html displays teacher information" do
    teacher = Teacher.find_by(name: "Leika")
    get "/teachers/#{teacher.id}"
    assert_response :success
    assert @response.body.include?("Leika")
  end

  test "show returns correct teacher json" do
    teacher = Teacher.find_by(name: "Leika")
    get "/teachers/#{teacher.id}.json"
    assert_response :success

    json = JSON.parse(@response.body)
    assert_equal "Leika", json["teacher_info"]["name"]
  end
  test "should create teacher with correct params" do
    post "/teachers.json", params: { name: "podo" }, as: :json
    assert_response 201

    json = JSON.parse(@response.body)
    assert_equal "podo", json["name"]
  end
  test "should create teacher with incorrect params" do
    post "/teachers.json", params: { name: "" }, as: :json
    assert_response 422

    json = JSON.parse(@response.body)
    puts json
    assert_equal [ "Name can't be blank" ], json["errors"]
  end
end
