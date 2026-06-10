class StudentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  skip_before_action :authenticate_user_with_token!, only: [ :index, :show ]
  # GET /students
  before_action :only_admin!, except: [ :index, :show ]
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
    @student = Student.new
    respond_to do |format|
      format.html do
      end
    end
  end
  def create
    @student = Student.new(student_params)
    respond_to do |format|
      format.html do
        if @student.save
          redirect_to students_path
        else
          render :new, status: :unprocessable_entity
        end
      end

      format.json do
        if @student.save
          render json: @student.as_json, status: 201
        else
          render json: { errors: @student.errors.full_messages }, status: 422
        end
      end
    end
  end

  def edit
    @student = Student.find(params[:id])
    respond_to do |format|
      format.html do
      end
    end
  end

  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html do
        if @student.update(student_params)
          redirect_to student_path(@student)
        else
          render :edit, status: :unprocessable_entity
        end
      end
      format.json do
        if @student.update(student_params)
          render json: @student.as_json, status: :ok
        else
          render json: { errors: @student.errors.full_messages }, status: 422
        end
      end
    end
  end

  def destroy
    @student = Student.find(params[:id])
    respond_to do |format|
      format.json do
        if @student.destroy
          render json: {}, status: 200
        else
          render json: { errors: [ "Only admin can delete Student" ] }, status: 401
        end
        format.html do
          if @student.destroy
            redirect_to students_path
          else
            redirect_to students_path, alert: "Only admin can delete student"
          end
        end
      end
    end
  end

  def student_params
    params.expect(student: [ :name, :grade, :term ])
  end
end
