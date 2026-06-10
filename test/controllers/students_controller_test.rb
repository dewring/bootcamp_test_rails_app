require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  def sign_in_as_user
    user = User.create!(email: "test@test.com", password: "password")
    sign_in user
  end

  test "index html displays students" do
    sign_in_as_user
    get "/students"
    assert_response :success
    assert @response.body.include?("Chiikawa")
  end

  test "index returns students as json" do
    user = User.create!(email: "test@test.com", password: "password")
    get "/students.json", headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response :success
    json = JSON.parse(@response.body)
    assert_equal "Chiikawa", json.first["name"]
    assert_equal 1, json.first["grade"]
    assert_equal "first", json.first["term"]
  end

  test "show html displays student information" do
    sign_in_as_user
    student = Student.find_by(name: "Hachiware")
    get "/students/#{student.id}"
    assert_response :success
    assert @response.body.include?("Hachiware")
    assert @response.body.include?("GRADE")
    assert @response.body.include?("TERM")
  end

  test "show returns correct student json" do
    user = User.create!(email: "test@test.com", password: "password")
    student = Student.find_by(name: "Chiikawa")
    get "/students/#{student.id}.json",
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response :success

    json = JSON.parse(@response.body)

    assert_equal student.id, json["id"]
    assert_equal "Chiikawa", json["name"]
    assert_equal 1, json["grade"]
    assert_equal "first", json["term"]
  end

  test "show returns classes and teachers as Json" do
    user = User.create!(email: "test@test.com", password: "password")
    student = Student.find_by(name: "Hachiware")

    get "/students/#{student.id}.json",
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response :success

    json = JSON.parse(@response.body)

    assert_equal [ "being cute" ], json["classes"]
    assert_equal [ "Jaina" ], json["teachers"]
  end

  test "should create student with correct params" do
    user = User.create!(email: "test@test.com", password: "password", role: "admin")
    post "/students.json",
      params: { name: "shisha", grade: 5, term: "second" },
      as: :json,
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response 201

    json = JSON.parse(@response.body)
    assert_equal "shisha", json["name"]
    assert_equal 5, json["grade"]
    assert_equal "second", json["term"]
  end
  test "should not create student with incorrect params" do
    user = User.create!(email: "test@test.com", password: "password", role: "admin")
    post "/students.json",
      params: { name: "shisha", grade: -5, term: "third" },
      as: :json,
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response 422

    json = JSON.parse(@response.body)
    assert_equal [ "Grade must be greater than 0", "Term is not included in the list" ], json["errors"]
  end
end
