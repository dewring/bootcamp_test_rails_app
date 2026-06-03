class Student < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :school_classes, through: :registrations
  has_many :teachers, through: :school_classes
end
