# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Registration.destroy_all
Student.destroy_all
SchoolClass.destroy_all
Teacher.destroy_all

teacher1 = Teacher.create!(name: "Leika")
teacher2 = Teacher.create!(name: "Jaina")

student1 = Student.create!(name: "Chiikawa", grade: 1, term: "first")
student2 = Student.create!(name: "Hachiware", grade: 2, term: "first")
student3 = Student.create!(name: "Usagi", grade: 2, term: "second")
student4 = Student.create!(name: "Momonga", grade: 3, term: "second")

class1 = SchoolClass.create!(subject: "being cute", teacher_id: teacher2.id)
class2 = SchoolClass.create!(subject: "hunting", teacher_id: teacher1.id)

Registration.create!(student_id: student1.id, school_class_id: class1.id, point: 80, booster: 20)
Registration.create!(student_id: student2.id, school_class_id: class1.id, point: 50, booster: 10)
Registration.create!(student_id: student3.id, school_class_id: class1.id, point: 25, booster: 10)
Registration.create!(student_id: student3.id, school_class_id: class2.id, point: 90, booster: 10)
Registration.create!(student_id: student4.id, school_class_id: class2.id, point: 70, booster: 10)
