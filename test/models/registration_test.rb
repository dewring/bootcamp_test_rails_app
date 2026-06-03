require "test_helper"

class RegistrationTest < ActiveSupport::TestCase
  test "student_id and school_class_id must be unique together" do
    teacher = Teacher.create!(name: "Leika")
    student = Student.create!(name: "Beef", grade: 2, term: "first")
    school_class = SchoolClass.create(subject: "being cute", teacher_id: teacher.id)
    registration = Registration.create(
      student_id: student.id,
      school_class_id: school_class.id,
      point: 80,
      booster: 20)
    assert registration.valid?

    assert_raises ActiveRecord::RecordInvalid do
      Registration.create!(
        student_id: student.id,
        school_class_id: school_class.id,
        point: 90,
        booster: 10)
    end
  end

  test "point must start from 0 to 100" do
    teacher = Teacher.create!(name: "Jaina")
    student = Student.create!(name: "Tuna", grade: 1, term: "first")
    school_class = SchoolClass.create(subject: "pooping", teacher_id: teacher.id)

    point = Registration.create(student_id: student.id, school_class_id: school_class.id, point: 50, booster: 20)
    assert point.valid?

    invalid_point = Registration.create(student_id: student.id, school_class_id: school_class.id, point: 123, booster: 0)
    assert invalid_point.invalid?
  end

  test "booster must start from 0 to 100" do
    teacher = Teacher.create!(name: "Jaina")
    student = Student.create!(name: "Tuna", grade: 1, term: "first")
    school_class = SchoolClass.create(subject: "pooping", teacher_id: teacher.id)

    booster = Registration.create(student_id: student.id, school_class_id: school_class.id, point: 72, booster: 0)
    assert booster.valid?

    invalid_booster = Registration.create(student_id: student.id, school_class_id: school_class.id, point: 50, booster: 120)
    assert invalid_booster.invalid?
  end
end
