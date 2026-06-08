class User < ApplicationRecord
  before_validation :ensure_api_token, on: :create
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :role, inclusion: { in: [ "teacher", "admin" ] }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :teacher

  def ensure_api_token
    self.api_token ||= SecureRandom.hex(20)
  end

  def admin?
    self.role == "admin"
  end

  def teacher?
    self.role == "teacher"
  end
end
