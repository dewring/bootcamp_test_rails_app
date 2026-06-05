require "test_helper"

class TeachersControllerTest < ActionDispatch::IntegrationTest
  test "index html displays teachers" do
    get "/teachers"
    assert_response :success
    assert @response.body.include?("teachers")
  end

  test "index returns teachers as json" do
    get "/teachers.json"
    assert_response :success

    json = JSON.parse(@response.body)
    assert_equal "Leika", json["teachers"].first["name"]
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
