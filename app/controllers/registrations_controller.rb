class RegistrationsController < ApplicationController
  def index
    if params[:school_class_id].present?
      @registrations = Registration.where(school_class_id: params[:school_class_id])
    else
      @registrations = Registration.all
    end
    @school_classes = SchoolClass.all
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
    unless helpers.can_create_resource?
      return  redirect_to student_registrations_path, alert: "Only admin or teacher can create registration"
    end
    @registration = Registration.new
    respond_to do |format|
      format.html do
      end
    end
  end
  def edit
    @registration = Registration.find(params[:id])

    unless helpers.can_manage_registration?(@registration)
      return  redirect_to student_registrations_path, alert: "Only admin or teacher can edit registration"
    end
    respond_to do |format|
      format.html do
      end
    end
  end
  def create
    unless helpers.can_create_resource?
      respond_to do |format|
        format.html { return redirect_to student_registrations_path, alert: "Only admin or teacher can create registration" }
        format.json { return render json: { errors: [ "Only admin or teacher can create registration" ] }, status: 401 }
      end
    end
    @registration = Registration.new(registration_params)
    # .new는 데이터베이스에는 영향을 주지 않는다 .create는 메모리에 객체를 만들고 데이터베이스에 저장까지 한다
    # 그래서 주로 .create는 console test 나 seed에 사용하고 컨트롤러에는 new나 create를 사용하지만 이 경우에는 new를 해야 충돌이 없다.
    respond_to do |format|
      format.html do
        if @registration.save
          redirect_to student_registrations_path
        else
          render :new, status: :unprocessable_entity
        end
      end
      format.json do
        if @registration.save
          render json: @registration.as_json, status: 201
        else
          render json: { errors: @registration.errors.full_messages }, status: 422
        end
      end
    end
  end
  def update
    # edit은 단순히 데이터를 보여주는 역할만 하는 거고 update는 진짜로 수정할 수 있게 하는 기능
    @registration = Registration.find(params[:id])
    unless helpers.can_manage_registration?(@registration)
      respond_to do |format|
        format.html { return redirect_to student_registrations_path, alert: "Only admin and owner teacher can update registration" }
        format.json { return render json: { errors: [ "Only admin and owner teacher can update registration" ] }, status: 401 }
      end
    end

    respond_to do |format|
      format.html do
        if @registration.update(registration_params)
          redirect_to student_registrations_path
        else
          render :edit, status: :unprocessable_entity
        end
      end

      format.json do
        if @registration.update(registration_params)
          render json: @registration.as_json, status: 200
        else
          render json: { errors: @registration.errors.full_messages }, status: 422
        end
      end
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    unless helpers.can_manage_registration?(registration)
      return redirect_to student_registrations_path, alert: "Only admin and owner teacher can delete registration"
    end
    @registration.destroy
    redirect_to student_registrations_path
  end

  def registration_params
    # ForbiddenAttributesError :
    # 컨트롤러가 허가되지 않은 브라우저 파라미터 데이터를 가지고 데이터베이스에 대량 저장(Mass-assignment) 작업을 시도할 때, 레일즈가 보안을 위해 발생시키는 런타임 에러입니다
    params.expect(registration: [ :student_id, :school_class_id, :point, :booster ])
  end
end
