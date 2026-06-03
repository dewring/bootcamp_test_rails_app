class Teacher < ApplicationRecord
  validates :name, presence: true

  has_many :school_classes, dependent: :nullify
  has_many :registrations, through: :school_classes
  has_many :students, through: :registrations
end
