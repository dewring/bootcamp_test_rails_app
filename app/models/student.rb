class Student < ApplicationRecord
  validates :name, presence: true
  validates :grade, numericality: { greater_than: 0 }
  validates :term, inclusion: { in: [ "first", "second" ] }

  has_many :registrations, dependent: :destroy
  has_many :school_classes, through: :registrations
  has_many :teachers, through: :school_classes

  scope :by_name, -> do
    order(name: :asc)
  end
  scope :in_first_term, -> { where(term: "first") }
  scope :in_grade, ->(grade) { where(grade: grade) }
end
