class SchoolClass < ApplicationRecord
  validates :subject, presence: true
  validates :teacher_id, presence: true

  belongs_to :teacher
  has_many :registrations, dependent: :destroy
  has_many :students, through: :registrations
end
