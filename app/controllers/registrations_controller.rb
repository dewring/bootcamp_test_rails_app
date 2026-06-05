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
  def create
    registration = Registration.create(registration_params)
      respond_to do |format|
       format.json do
        if registration.valid?
          render json: registration.as_json, status: 201
        else
          render json: { errors: registration.errors.full_messages }, status: 422
        end
      end
    end
  end
  def registration_params
    params.expect(registration: [ :student_id, :school_class_id, :point, :booster ])
  end
end
