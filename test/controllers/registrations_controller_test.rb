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
  test "should create registration with correct params" do
    student = Student.create!(name: "manju", grade: 6, term: "second")
    teacher = Teacher.create!(name: "hodo")
    school_class = SchoolClass.create!(subject: "draw with poo", teacher_id: teacher.id)
    post "/registrations.json", params: {
      student_id: student.id,
      school_class_id: school_class.id,
      point: 50,
      booster: 10
      }, as: :json
    assert_response 201

    json = JSON.parse(@response.body)
    assert_equal student.id, json["student_id"]
    assert_equal school_class.id, json["school_class_id"]
    assert_equal 50, json["point"]
    assert_equal 10, json["booster"]
  end
  test "should not create registration with incorrect params" do
    post "/registrations.json", params: { student_id: "", school_class_id: "", point: -50, booster: -10 }, as: :json
    assert_response 422

    json = JSON.parse(@response.body)
    assert_includes json["errors"], "Student must exist"
    assert_includes json["errors"], "School class must exist"
    assert_includes json["errors"], "Point must be in 0..100"
    assert_includes json["errors"], "Booster must be in 0..100"
  end
end
