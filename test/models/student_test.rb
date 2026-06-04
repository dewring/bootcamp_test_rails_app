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
    # puts first_student.name
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
  test "what is the sum of total booster of all students?" do
    total_booster = Registration.sum(:booster)
    assert_equal 60, total_booster
    # i'm little bit confuse to :"" or "":
  end
  test "How many students are not in grade 2?" do
    not_grade_2 = Student.where.not(grade: 2).count
    assert_equal 2, not_grade_2
  end
  test "what are the names of all students?" do
    student_list = Student.pluck(:name)
    assert_equal [ "Chiikawa", "Hachiware", "Usagi", "Momonga" ], student_list
  end
  test "what are the names of all student not in grade 1" do
    not_grade1_student_list = Student.where.not(grade: 1).pluck(:name)
    assert_equal [ "Hachiware", "Usagi", "Momonga" ], not_grade1_student_list
  end
  test "calculate total point sum from chiikawa and hachiware" do
    students = Student.where(name: [ "Chiikawa", "Hachiware" ]).pluck(:id)
    total_point = Registration.where(student_id: students).sum(:point)
    assert_equal 130, total_point
  end
end
