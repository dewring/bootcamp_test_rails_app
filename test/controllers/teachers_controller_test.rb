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
    # 제이슨에서는 sign in 대신 토큰이 필요하기 때문에
    # html과 다르게 토큰을 전송하는 테스트를 해야한다.
    # #그래서 json 테스트안에는 직접 user를 만드는 작업을 하는게 좋다
    user = User.create!(email: "test@test.com", password: "password")
    get "/teachers.json", headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response :success
  end

  test "show html displays teacher information" do
    sign_in_as_user
    teacher = Teacher.find_by(name: "Leika")
    get "/teachers/#{teacher.id}"
    assert_response :success
    assert @response.body.include?("Leika")
  end

  test "show returns correct teacher json" do
    user = User.create!(email: "test@test.com", password: "password")
    teacher = Teacher.find_by(name: "Leika")
    get "/teachers/#{teacher.id}.json",
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response :success
    json = JSON.parse(@response.body)
    assert_equal "Leika", json["teacher_info"]["name"]
  end

  test "should create teacher with correct params as json" do
    user = User.create!(email: "test@test.com", password: "password")
    post "/teachers.json", params: { name: "podo" }, as: :json,
      headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response 201
  end

  test "create html creates a teacher" do
    sign_in_as_user
    post "/teachers", params: { teacher: { name: "podo" } }
    assert_response :redirect
    follow_redirect!
    assert @response.body.include?("podo")
  end

  test "should create teacher with incorrect params as json" do
    user = User.create!(email: "test@test.com", password: "password")
    post "/teachers.json", params: { name: "" }, as: :json,
        headers: { "Authorization" => "Bearer #{user.api_token}" }
    assert_response 422
    json = JSON.parse(@response.body)
    assert_equal [ "Name can't be blank" ], json["errors"]
  end
end
