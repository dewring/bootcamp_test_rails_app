class StudentsController < ApplicationController
  STUDENTS = [ "Kelvin", "Leika", "Jade", "Litzi" ]
  def index
    @students = STUDENTS
  end
  def show
    @student = STUDENTS[params[:id].to_i]
  end
end
