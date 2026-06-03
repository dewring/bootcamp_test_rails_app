require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "name must be not empty" do
    student = Student.create(name: "Leika", grade: 1, term: "first")
    # puts student.errors.full_messages
    assert student.valid?

    invalid_student = Student.create(name: "", grade: 1, term: "first")
    assert invalid_student.invalid?
  end
  test "grade must be more than 0" do
    student = Student.create(name: "Tuna", grade: 19, term: "second")
    assert student.valid?

    invalid_student = Student.create(name: "Tuna", grade: -3, term: "second")
    assert invalid_student.invalid?
  end
  test "term must be either first or second" do
    student = Student.create(name: "Tuna", grade: 19, term: "second")
    assert student.valid?

    invalid_student = Student.create(name: "Tuna", grade: 19, term: "fifth")
    assert invalid_student.invalid?
  end
end
