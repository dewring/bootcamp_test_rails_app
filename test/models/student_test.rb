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
    student = Student.create(name: "Auna", grade: 19, term: "second")
    assert student.valid?

    invalid_student = Student.create(name: "Tuna", grade: 19, term: "fifth")
    assert invalid_student.invalid?
  end

  test "by_name scope should order students by name in ascending order" do
    first_student = Student.by_name.first
    puts first_student.name
    assert_equal "Chiikawa", first_student.name
  end
  test "in_first_term should return students in the first term" do
    first_term_students = Student.in_first_term
    for student in first_term_students
      assert_equal "first", student.term
    end
  end
  test "in_grade should return students in the specified grade" do
    first_grade_students = Student.in_grade(1)
    for student in first_grade_students
      assert_equal 1, student.grade
    end
  end
  test "How many classes exist?" do
    classes = SchoolClass.count
    assert_equal 2, classes
  end
  test "What is the first student's name?" do
    first_student = Student.first
    assert_equal "Chiikawa", first_student.name
  end
  test "How much point has Usagi student in hunting class?" do
    usagi = Student.find_by(name: "Usagi")
    hunting = SchoolClass.find_by(subject: "hunting")
    point = Registration.find_by(student_id: usagi.id, school_class_id: hunting.id).point
    assert_equal 90, point
  end
  test "how many students is taking being cute class?" do
    being_cute = SchoolClass.find_by(subject: "being cute")
    students = Registration.where(school_class_id: being_cute.id).count
    assert_equal 3, students
  end
  test "who is the highest point in hunting class" do
    hunting = SchoolClass.find_by(subject: "hunting")
    highest_student = Registration.where(school_class_id: hunting.id).order(point: :desc).first.student
    assert_equal "Usagi", highest_student.name
  end
end
