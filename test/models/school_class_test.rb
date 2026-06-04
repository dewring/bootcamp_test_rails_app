require "test_helper"

class SchoolClassTest < ActiveSupport::TestCase
 test "subject must be not empty" do
   teacher = Teacher.create!(name: "Jaina")
   school_class = SchoolClass.create(subject: "pooping", teacher_id: teacher.id)
   puts school_class.errors.full_messages
   assert school_class.valid?

   invalid_school_class = SchoolClass.create(subject: "", teacher_id: teacher.id)
   assert invalid_school_class.invalid?
  end
end
