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
     @school_class = SchoolClass.new
      respond_to do |format|
        format.html do
        end
      end
    end
  def edit
    @school_class = SchoolClass.find(params[:id])
    respond_to do |format|
      format.html do
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
          if @school_class.save
            redirect_to school_classes_path
          else
            render :new, status: :unprocessable_entity
          end
        end

       format.json do
        if @school_class.save
          render json: @school_class.as_json, status: 201
        else
          render json: { errors: @school_class.errors.full_messages }, status: 422
        end
      end
    end
  end
  def update
    @school_class = SchoolClass.find(params[:id])
    if @school_class.update(school_class_params)
      redirect_to school_class_path(@school_class)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def school_class_params
    params.expect(school_class: [ :subject, :teacher_id ])
  end
end
