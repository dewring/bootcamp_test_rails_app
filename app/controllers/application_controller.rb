class ApplicationController < ActionController::Base
  class NotAdminError < StandardError
  end
  class CantManageError < StandardError
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  before_action :authenticate_user!, unless: -> { request.format.json? }
  before_action :authenticate_user_with_token!, if: -> { request.format.json? }

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from NotAdminError, with: :not_admin
  rescue_from CantManageError, with: :not_admin_teacher

  def record_not_found
    respond_to do |format|
      format.html do
        redirect_back_or_to root_url, alert: "Couldn't find resource"
      end
      format.json do
        render json: { error: "Resource not found" }, status: 404
      end
    end
  end

  def not_admin
    respond_to do |format|
      format.html do
        redirect_back_or_to root_url, alert: "You're not Admin"
      end
      format.json do
        render json: { error: "You're not Admin" }, status: 401
      end
    end
  end

  def only_admin!
    unless current_user != nil && current_user.admin?
      logger.info "User #{current_user.email} tried to enter admin section." if current_user != nil
      raise NotAdminError
    end
  end

  def not_admin_teacher
    respond_to do |format|
      format.html do
        redirect_back_or_to root_url, alert: "You aren't admin or teacher"
      end
      format.json do
        render json: { error: "You aren't admin or teacher" }, status: 401
      end
    end
  end

  def only_admin_teacher!
    unless current_user != nil && can_create_resource?
      logger.info "User #{current_user.email} tried to enter admin and teacher section." if current_user != nil
      raise CantManageError
    end
  end

  def only_admin_or_owner!
    unless current_user != nil && can_manage?
      logger.info "User #{current_user.email} tried to enter admin and teacher section." if current_user != nil
      raise CantManageError
    end
  end

  def can_manage?
    raise NotImplementedError
  end

  def authenticate_user_with_token!
    token = request.headers["Authorization"]&.split(" ")&.last

    if token.nil?
      return render json: { error: "Empty token" }, status: :unauthorized
    end

    user = User.find_by(api_token: token)

    if user.nil?
      return render json: { error: "User not found" }, status: :unauthorized
    end

    @current_user = user
  end
end
