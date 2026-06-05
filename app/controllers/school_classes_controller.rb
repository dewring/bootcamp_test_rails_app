class SchoolClassesController < ApplicationController
  def index
    @school_classes = SchoolClass.all

    respond_to do |format|
      format.json do
        render json: @school_classes.map do |sc|
          {
            id: sc.id,
            subject: sc.subject,
            teacher_id: sc.teacher_id
          }
        end
      end
      format.html do
      end
    end
  end

  def show
    @school_class = SchoolClass.find(params[:id])

    respond_to do |format|
      format.json do
        render json: {
          id: @school_class.id,
          subject: @school_class.subject,
          teacher_name: @school_class.teacher.name,
          students: @school_class.students.pluck(:name)
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
  def create
    school_class = SchoolClass.create(school_class_params)
      respond_to do |format|
       format.json do
        if school_class.valid?
          render json: school_class.as_json, status: 201
        else
          render json: { errors: school_class.errors.full_messages }, status: 422
        end
      end
    end
  end
  def school_class_params
    params.expect(school_class: [ :subject, :teacher_id ])
  end
end
