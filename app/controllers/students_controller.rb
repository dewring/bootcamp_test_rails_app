class StudentsController < ApplicationController
  STUDENTS = [
    { name: "Kelvin", language: "Ruby" },
    { name: "Jade", language: "Ruby" },
    { name: "Litzi", language: "Ruby" }
  ]
  def index
    @students = STUDENTS
  end
  def show
    @student = STUDENTS[params[:id].to_i]
  end
end
