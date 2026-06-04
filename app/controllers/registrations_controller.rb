class RegistrationsController < ApplicationController
  def index
    @registrations = Registration.all

    respond_to do |format|
      format.json do
        render json: @registrations.map do |r|
          { id: r.id,
            student_id: r.student_id,
            school_class_id: r.school_class_id,
            point: r.point, booster: r.booster }
        end
      end
      format.html do
      end
    end
  end

  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.json do
        render json: {
          id: @registration.id,
          student_name: @registration.student.name,
          subject: @registration.school_class.subject,
          point: @registration.point,
          booster: @registration.booster
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
