require "test_helper"

class SchoolClassesControllerTest < ActionDispatch::IntegrationTest
  def sign_in_as_user
    user = User.create!(email: "test@test.com", password: "password")
    sign_in user
  end

  test "index html displays school class" do
    sign_in_as_user
    get "/school_classes"
    assert_response :success
    assert @response.body.include?("school_classes")
  end

  test "index returns school classes as json array" do
    user = User.create!(email: "test@test.com", password: "password")
    get "/school_classes.json",
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response :success

    json = JSON.parse(@response.body)
    assert_equal "hunting", json.last["subject"]
  end

  test "show html loads successfully" do
    sign_in_as_user
    school_class = SchoolClass.find_by(subject: "being cute")

    get "/school_classes/#{school_class.id}"
    assert_response :success
  end

  test "show returns correct school class json data" do
    user = User.create!(email: "test@test.com", password: "password")
    school_class = SchoolClass.find_by(subject: "being cute")

    get "/school_classes/#{school_class.id}.json",
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response :success

    json = JSON.parse(@response.body)
    assert_equal "being cute", json["subject"]
    assert_equal "Jaina", json["teacher_name"]
    assert_equal "Usagi", json["students"].last
  end

  test "should create schoolclass with correct params as json" do
    user = User.create!(email: "test@test.com", password: "password")
    teacher = Teacher.create!(name: "choco")
    post "/school_classes.json", params: {
      subject: "being lazy",
      teacher_id: teacher.id
      }, as: :json,
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response 201

    json = JSON.parse(@response.body)
    assert_equal "being lazy", json["subject"]
    assert_equal teacher.id, json["teacher_id"]
  end

   test "create html creates a schoolclass with correct params" do
      sign_in_as_user
      teacher = Teacher.create!(name: "choco")
      post "/school_classes", params: {
        school_class: {
      subject: "being lazy",
      teacher_id: teacher.id
       }
      }
      assert_response :redirect
      follow_redirect!
      assert @response.body.include?("being lazy")
      assert @response.body.include?("#{teacher.id}")
   end
  test "should not create schoolclass with incorrect params as json" do
    user = User.create!(email: "test@test.com", password: "password")
    post "/school_classes.json", params: { subject: "", teacher_id: "" },
      as: :json,
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response 422

    json = JSON.parse(@response.body)
    assert_includes json["errors"], "Subject can't be blank"
    assert_includes json["errors"], "Teacher must exist"
  end
end
