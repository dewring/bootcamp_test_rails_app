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
        unless current_user.admin?
          redirect_to teachers_path, alert: "Only admin can create Teacher"
        end
      end
    end
  end
  def create
    @teacher = Teacher.new(teacher_params)
    respond_to do |format|
      format.html do
        if current_user.admin?
          if @teacher.save
            redirect_to teachers_path
          else
            render :new, status: :unprocessable_entity
          end
        else
          redirect_to teachers_path, alert: "Only admin can create Teacher"
        end
      end

      format.json do
        if current_user.admin?
          if @teacher.save
            render json: @teacher.as_json, status: 201
          else
            render json: { errors: @teacher.errors.full_messages }, status: 422
          end
        else
          render json: { errors: [ "Only admin can create Teacher" ] }, status: 401
        end
      end
    end
  end
  def edit
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      format.html do
        unless current_user.admin?
          redirect_to teachers_path, alert: "Only admin can edit Teacher"
        end
      end
    end
  end

  def update
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      format.html do
        if current_user.admin?
          if @teacher.update(teacher_params)
            redirect_to teacher_path(@teacher)
          else
            render :edit, status: :unprocessable_entity
          end
        else
          redirect_to teachers_path, alert: "Only admin can update Teacher"
        end
      end
      format.json do
        if current_user.admin?
          if @teacher.update(teacher_params)
            render json: @teacher.as_json, status: :ok
          else
            render json: { errors: @teacher.errors.full_messages }, status: 422
          end
        else
          render json: { errors: [ "Only admin can update Teacher" ] }, status: 401
        end
      end
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      format.html do
        if current_user.admin?
          @teacher.destroy
          redirect_to teachers_path
        else
          redirect_to teachers_path, alert: "Only admin can delete Teacher"
        end
      end

      format.json do
        if current_user.admin?
          @teacher.destroy
          render json: {}, status: 200
        else
          render json: { errors: [ "Only admin can delete Teacher" ] }, status: 401
        end
      end
    end
  end

  def teacher_params
    params.expect(teacher: [ :name ])
  end
end
