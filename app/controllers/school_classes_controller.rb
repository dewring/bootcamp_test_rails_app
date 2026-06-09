class SchoolClassesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  skip_before_action :authenticate_user_with_token!, only: [ :index, :show ]

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
    @school_class = SchoolClass.new
    if current_user.teacher?
      @school_class.teacher = current_user.teacher
    end

    respond_to do |format|
      format.html do
        unless current_user.admin? || current_user.teacher?
          redirect_to school_classes_path, alert: "Only admin or teacher can create School Class"
        end
      end
    end
  end
  def create
    @school_class = SchoolClass.new(school_class_params)
    respond_to do |format|
      format.html do
        # @school_class.save와  @school_class.valid?의 차이점은
        # valid?는 유효검사만 하고 직접 저장하지 않고 save는 직접 저장한다
        # 제이드한테 왜 valid?를 넣었었는지 묻기
        if current_user.admin? || @school_class.teacher.user_id == current_user.id
          if @school_class.save
            redirect_to school_classes_path
          else
            render :new, status: :unprocessable_entity
          end
        else
          redirect_to school_classes_path, alert: "Only admin or owner can create School Class"
        end
      end

      format.json do
        if current_user.admin? || @school_class.teacher.user_id == current_user.id
          if @school_class.save
            render json: @school_class.as_json, status: 201
          else
            render json: { errors: @school_class.errors.full_messages }, status: 422
          end
        else
          render json: { errors: [ "Only admin or owner can create School Class" ] }
        end
      end
    end
  end
  def edit
    @school_class = SchoolClass.find(params[:id])

    respond_to do |format|
      format.html do
        unless current_user.admin? || @school_class.teacher.user_id == current_user.id
          redirect_to school_classes_path, alert: "Only admin or owner can edit School Class"
        end
      end
    end
  end
  def update
    @school_class = SchoolClass.find(params[:id])

    respond_to do |format|
      format.html do
        if current_user.admin? || @school_class.teacher.user_id == current_user.id
          if @school_class.update(school_class_params)
            redirect_to school_class_path(@school_class)
          else
            render :edit, status: :unprocessable_entity
          end
        else
          redirect_to school_classes_path, alert: "Only admin or owner can update School Class"
        end
      end
      format.json do
        if current_user.admin? || @school_class.teacher.user_id == current_user.id
          if @school_class.update(school_class_params)
            render json: @school_class.as_json, status: :ok
          else
            render json: { errors: @school_class.errors.full_messages }, status: 422
          end
        else
          render json: { errors: [ "Only admin or owner can update School Class" ] }, status: 401
        end
      end
    end
  end

  def destroy
    @school_class = SchoolClass.find(params[:id])

    respond_to do |format|
      format.html do
        if current_user.admin? || @school_class.teacher.user_id == current_user.id
          @school_class.destroy
          redirect_to school_classes_path
        else
          redirect_to school_classes_path, alert: "Only admin or owner can delete School Class"
        end
      end
    end
  end

  private
  # private을 넣으면 이 클래스안에서만 정의된다
  def school_class_params
    params.expect(school_class: [ :subject, :teacher_id ])
  end
end
