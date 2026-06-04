class Registration < ApplicationRecord
  validates :student_id, uniqueness: { scope: :school_class_id }
  validates :point, numericality: { in: 0..100 }
  validates :booster, numericality: { in: 0..100 }

  belongs_to :student
  belongs_to :school_class, dependent: :destroy
end
