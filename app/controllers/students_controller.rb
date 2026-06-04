class StudentsController < ApplicationController
  # GET /students
  def index
    @students = Student.all

    respond_to do |format|
      format.json do
        render json: @students.map do |s|
          { id: s.id,
            name: s.name,
            grade: s.grade,
             term: s.term }
        end
      end

      format.html do
      end
    end
  end
  # GET /students/:id
  def show
    @student = Student.find(params[:id])
    respond_to do |format|
      format.html do
      end

      format.json do
        render json: {
          id: @student.id,
          name: @student.name,
          grade: @student.grade,
          term: @student.term,
          classes: @student.school_classes.pluck(:subject),
          teachers: @student.teachers.pluck(:name).uniq
        }
      end
    end
  end
  def new
    respond_to do |format|
      format.html do
      end
    end
  end
end
