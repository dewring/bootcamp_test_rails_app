class Registration < ApplicationRecord
  belongs_to :student
  belongs_to :school_class, dependent: :destroy
end
