class SchoolClass < ApplicationRecord
  belongs_to :teacher
  has_many :registrations, dependent: :destroy
  has_many :students, through: :registrations
end
