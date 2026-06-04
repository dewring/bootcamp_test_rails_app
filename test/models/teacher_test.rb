require "test_helper"

class TeacherTest < ActiveSupport::TestCase
  test "name must be not empty" do
    teacher = Teacher.create(name: "Jaina")
    assert teacher.valid?

    invalid_teacher = Teacher.create(name: "")
    assert invalid_teacher.invalid?
  end
end
