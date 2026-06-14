# app/helpers/application_helper.rb
module ApplicationHelper
  def can_create_resource?
    current_user.admin? || current_user.teacher?
  end

  def can_manage_registration?(registration)
    current_user.admin? || registration.school_class.teacher.user_id == current_user.id
  end

  def can_manage_school_class?(school_class)
    current_user.admin? || school_class.teacher.user_id == current_user.id
  end

  def admin_only?
    current_user.admin?
  end
end
