class User < ApplicationRecord
  before_validation :ensure_api_token, on: :create
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def ensure_api_token
    self.api_token ||= SecureRandom.hex(20)
  end
end
