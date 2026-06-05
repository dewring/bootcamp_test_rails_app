require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  test "index html displays students" do
    get "/students"
    assert_response :success
    assert @response.body.include?("Chiikawa")
  end
  test "index returns students as json" do
    get "/students.json"

    assert_response :success

    json = JSON.parse(@response.body)
    puts json

    assert_equal "Chiikawa", json.first["name"]
    assert_equal 1, json.first["grade"]
    assert_equal "first", json.first["term"]
  end

  test "show returns correct student json" do
    student = Student.find_by(name: "Chiikawa")

    get "/students/#{student.id}.json"

    assert_response :success

    json = JSON.parse(@response.body)

    assert_equal student.id, json["id"]
    assert_equal "Chiikawa", json["name"]
    assert_equal 1, json["grade"]
    assert_equal "first", json["term"]
  end

  test "show returns classes and teachers as Json" do
    student = Student.find_by(name: "Hachiware")

    get "/students/#{student.id}.json"

    assert_response :success

    json = JSON.parse(@response.body)

    assert_equal [ "being cute" ], json["classes"]
    assert_equal [ "Jaina" ], json["teachers"]
  end
  test "show html displays student information" do
  student = Student.find_by(name: "Hachiware")

  get "/students/#{student.id}"

  assert_response :success

  assert @response.body.include?("NAME: Hachiware")
  assert @response.body.include?("GRADE:")
  assert @response.body.include?("TERM:")
  end
  test "should create student with correct params" do
    post "/students.json", params: { name: "shisha", grade: 5, term: "second" }, as: :json
    assert_response 201

    json = JSON.parse(@response.body)
    assert_equal "shisha", json["name"]
    assert_equal 5, json["grade"]
    assert_equal "second", json["term"]
  end
  test "should create student with incorrect params" do
    post "/students.json", params: { name: "shisha", grade: -5, term: "third" }, as: :json
    assert_response 422

    json = JSON.parse(@response.body)
    puts json
    assert_equal [ "Grade must be greater than 0", "Term is not included in the list" ], json["errors"]
  end
end
