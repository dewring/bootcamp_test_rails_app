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

      format.html do
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

      format.html do
      end
    end
  end
  def new
    respond_to do |format|
      format.html do
      end
    end
  end
  def edit
    respond_to do |format|
      format.html do
      end
    end
  end
end
