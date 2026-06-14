require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  def current_user
    @current_user
  end

  test "admin_only? returns true for admin" do
    @current_user = User.new(role: "admin")
    assert admin_only?
  end

  test "admin_only? returns false for non-admin" do
    @current_user = User.new(role: "teacher")
    refute admin_only?
  end

  test "can_create_resource? returns true for admin" do
    @current_user = User.new(role: "admin")
    assert can_create_resource?
  end

  test "can_create_resource? returns true for teacher" do
    @current_user = User.new(role: "teacher")
    assert can_create_resource?
  end

  test "can_create_resource? returns false for student" do
    @current_user = User.new(role: "student")
    refute can_create_resource?
  end

  test "can_manage_registration? returns true for admin" do
    @current_user = User.create!(email: "test@test.com", password: "testtest", role: "admin")
    assert can_manage_registration?(Registration.new)
  end

  test "can_manage_registration? returns true for owner teacher" do
    @current_user = User.create!(email: "test@test.com", password: "testtest", role: "teacher")
    @teacher = Teacher.create!(name: "Test", user: @current_user)
    @school_class = SchoolClass.create!(subject: "Test", teacher: @teacher)
    @student = Student.create!(name: "Test_st", grade: 1, term: "first")
    @registration = Registration.create!(school_class: @school_class, student: @student, point: 10, booster: 10)
    assert can_manage_registration?(@registration)
  end

  test "can_manage_registration? returns false for non-owner teacher" do
    @current_user = User.create!(email: "test@test.com", password: "testtest", role: "teacher")
    @other_user = User.create!(email: "tttt@test.com", password: "testtest", role: "teacher")
    @teacher = Teacher.create!(name: "Test", user: @other_user)
    @school_class = SchoolClass.create!(subject: "Test", teacher: @teacher)
    @student = Student.create!(name: "Test_st", grade: 1, term: "first")
    @registration = Registration.create!(school_class: @school_class, student: @student, point: 10, booster: 10)
    refute can_manage_registration?(@registration)
  end

  test "can_manage_school_class? returns true for admin" do
    @current_user = User.create!(email: "test@test.com", password: "testtest", role: "admin")
    assert can_manage_school_class?(SchoolClass.new)
  end

  test "can_manage_school_class? returns true for owner teacher" do
    @current_user = User.create!(email: "test@test.com", password: "testtest", role: "teacher")
    @teacher = Teacher.create!(name: "Test", user: @current_user)
    @school_class = SchoolClass.create!(subject: "Test", teacher: @teacher)
    assert can_manage_school_class?(@school_class)
  end

  test "can_manage_school_class? returns false for non-owner teacher" do
    @current_user = User.create!(email: "test@test.com", password: "testtest", role: "teacher")
    @other_user = User.create!(email: "tttt@test.com", password: "testtest", role: "teacher")
    @teacher = Teacher.create!(name: "Test", user: @other_user)
    @school_class = SchoolClass.create!(subject: "Test", teacher: @teacher)
    refute can_manage_school_class?(@school_class)
  end
end
