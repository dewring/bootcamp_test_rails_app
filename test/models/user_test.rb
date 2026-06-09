require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "it must has role as teacher or admin" do
    user = User.create!(email: "leikaa@example.com", password: "leikaka", role: "teacher")
    assert user.valid?

    invalid_user = User.create(email: "leikaaa@example.com", password: "leikaka", role: "pitillo")
    assert invalid_user.invalid?
    assert invalid_user.errors.full_messages, "should put teacher or admin"
  end

  test "#admin? should be true if user is admin" do
    user_admin = User.find_by(role: "admin")
    assert user_admin.admin?
  end

  test "#teacher? should be true if user is teacher" do
    user_teacher = User.find_by(role: "teacher")
    assert user_teacher.teacher?
  end
end
