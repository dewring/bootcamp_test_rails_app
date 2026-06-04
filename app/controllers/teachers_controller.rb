class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all

    respond_to do |format|
      format.json do
        render json: {
          teachers: @teachers.map do |teacher|
            { id: teacher.id, name: teacher.name }
            end
          }
      end
    end
  end

  def show
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      format.json do
        render json: {
          teacher_info: {
            id: @teacher.id,
            name: @teacher.name
          }
        }
      end
    end
  end
end
