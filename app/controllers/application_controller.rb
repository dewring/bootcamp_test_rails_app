class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  before_action :authenticate_user!, unless: -> { request.format.json? }
  before_action :authenticate_user_with_token!, if: -> { request.format.json? }

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
