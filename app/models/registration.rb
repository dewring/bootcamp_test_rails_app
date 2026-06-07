class Registration < ApplicationRecord
  validates :student_id, uniqueness: { scope: :school_class_id }
  validates :point, numericality: { in: 0..100 }
  validates :booster, numericality: { in: 0..100 }
  validates :point, numericality: {
    less_than_or_equal_to: ->(r) { 100 - r.booster.to_i },
    message: "and booster combined cannot exceed 100"
  }

  belongs_to :student
  belongs_to :school_class
end
