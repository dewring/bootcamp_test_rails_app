require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  def sign_in_as_user
    user = User.create!(email: "test@test.com", password: "password")
    sign_in user
  end

  test "index html displays registrations" do
    sign_in_as_user
    get "/student_registrations"
    # 라우트 설정을 바꿨기때문에 주소도 바꿔야됨
    assert_response :success
    assert @response.body.include?("registrations")
  end

  test "index returns registrations as json array" do
    user = User.create!(email: "test@test.com", password: "password")
    get "/student_registrations.json",
    headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response :success

    json = JSON.parse(@response.body)
    assert_equal 80, json.first["point"]
    assert_equal 10, json.last["booster"]
  end

  test "show html loads successfully" do
    sign_in_as_user
    registration = Registration.first
    get "/student_registrations/#{registration.id}"
    assert_response :success
  end

  test "show returns correct registration json data" do
    user = User.create!(email: "test@test.com", password: "password")
    registration = Registration.first
    get "/student_registrations/#{registration.id}.json",
    headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response :success

    json = JSON.parse(@response.body)
    # assert_equal registration.id, json["id"]
    assert_equal 80, json["point"]
    assert_equal 20, json["booster"]
    assert_equal "Chiikawa", json["student_name"]
    assert_equal "being cute", json["subject"]
  end
  test "should create registration with correct params as json" do
    user = User.create!(email: "test@test.com", password: "password")
    student = Student.create!(name: "manju", grade: 6, term: "second")
    teacher = Teacher.create!(name: "hodo")
    school_class = SchoolClass.create!(subject: "draw with poo", teacher_id: teacher.id)
    post "/student_registrations.json", params: {
      student_id: student.id,
      school_class_id: school_class.id,
      point: 50,
      booster: 10
      }, as: :json,
      headers: { "Authorization" => "Bearer #{user.api_token}" }

    assert_response 201

    json = JSON.parse(@response.body)
    assert_equal student.id, json["student_id"]
    assert_equal school_class.id, json["school_class_id"]
    assert_equal 50, json["point"]
    assert_equal 10, json["booster"]
  end

  test "create html creates a registration with correct params" do
    sign_in_as_user
    student = Student.create!(name: "manju", grade: 6, term: "second")
    teacher = Teacher.create!(name: "hodo")
    school_class = SchoolClass.create!(subject: "draw with poo", teacher_id: teacher.id)
    post "/student_registrations",
    params: {
      registration: {
      student_id: student.id,
      school_class_id: school_class.id,
      point: 50,
      booster: 10
      }
    }
    assert_response :redirect
    follow_redirect!
    assert @response.body.include?("manju")
    assert @response.body.include?("draw with poo")
    assert @response.body.include?("50")
  end

  test "should not create registration with incorrect params" do
    user = User.create!(email: "test@test.com", password: "password")
    post "/student_registrations.json",
      params: { student_id: "", school_class_id: "", point: -50, booster: -10 },
      as: :json,
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response 422

    json = JSON.parse(@response.body)
    assert_includes json["errors"], "Student must exist"
    assert_includes json["errors"], "School class must exist"
    assert_includes json["errors"], "Point must be in 0..100"
    assert_includes json["errors"], "Booster must be in 0..100"
  end
end
