class Teacher < ApplicationRecord
  validates :name, presence: true

  has_many :school_classes, dependent: :nullify
  has_many :registrations, through: :school_classes
  has_many :students, through: :registrations

  belongs_to :user, optional: true

  # before_validation :test_method_before_validation
  # after_validation :test_method_after_validation
  # before_save :test_method_before_save
  # after_save :test_method_after_save
  # before_create :test_method_before_create
  # after_create :test_method_after_create


  # def test_method_before_validation
  #   puts "Teacher #{self.name} is being validated."
  # end

  # def test_method_after_validation
  #   puts "Teacher #{self.name} has been validated. Errors: #{self.errors.full_messages.join(", ")}"
  # end

  # def test_method_before_save
  #   puts "Teacher #{self.name} is being saved."
  # end

  # def test_method_after_save
  #   puts "Teacher #{self.name} has been saved with id #{self.id}."
  # end

  # def test_method_before_create
  #   puts "Teacher #{self.name} is being created."
  # end

  # def test_method_after_create
  #   puts "Teacher #{self.name} has been created with id #{self.id}."
  # end
end
