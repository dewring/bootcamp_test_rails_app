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
    end
  end
end
