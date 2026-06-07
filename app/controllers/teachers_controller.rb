class TeachersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  skip_before_action :authenticate_user_with_token!, only: [ :index, :show ]
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
      @teacher = Teacher.new
    respond_to do |format|
      format.html do
      end
    end
  end
  def edit
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      format.html do
      end
    end
  end
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      format.html do
        if @teacher.save
          redirect_to teachers_path
        else
          render :new, status: :unprocessable_entity
        end
      end

      format.json do
        if @teacher.valid?
          render json: @teacher.as_json, status: 201
        else
          render json: { errors: @teacher.errors.full_messages }, status: 422
        end
      end
    end
  end
  def update
    @teacher = Teacher.find(params[:id])

    if @teacher.update(teacher_params)
      redirect_to teacher_path(@teacher)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to teachers_path
  end

  def teacher_params
    params.expect(teacher: [ :name ])
  end
end
