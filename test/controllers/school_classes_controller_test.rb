require "test_helper"

class SchoolClassesControllerTest < ActionDispatch::IntegrationTest
  test "index html displays school class" do
    get "/school_classes"
    assert_response :success
    assert @response.body.include?("school_classes")
  end

  test "index returns school classes as json array" do
    get "/school_classes.json"
    assert_response :success

    json = JSON.parse(@response.body)
    assert_equal "hunting", json.last["subject"]
  end
  test "show html loads successfully" do
    school_class = SchoolClass.find_by(subject: "being cute")

    get "/school_classes/#{school_class.id}"
    assert_response :success
  end

  test "show returns correct school class json data" do
    school_class = SchoolClass.find_by(subject: "being cute")

    get "/school_classes/#{school_class.id}.json"
    assert_response :success

    json = JSON.parse(@response.body)
    assert_equal "being cute", json["subject"]
    assert_equal "Jaina", json["teacher_name"]
    assert_equal "Usagi", json["students"].last
  end
end
