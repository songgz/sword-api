class V1::StudentsController < ApplicationController
  before_action :set_v1_student, only: %i[ show update destroy ]

  # GET /v1/students
  # GET /v1/students.json
  def index
    @v1_students = Student.all
    @v1_students = @v1_students.full_text_search(params[:key]) if params[:key].present?
    @v1_students = @v1_students.order(id: :desc)
    @pagination = pagination(@v1_students.page(params[:page]).per(params[:pre]))
  end

  # GET /v1/students/1
  # GET /v1/students/1.json
  def show
  end

  # POST /v1/students
  # POST /v1/students.json
  def create
    @v1_student = Student.new(v1_student_params)

    if @v1_student.save
      render :show, status: :created, location: v1_student_url(@v1_student)
    else
      render json: @v1_student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/students/1
  # PATCH/PUT /v1/students/1.json
  def update
    if @v1_student.update(v1_student_params)
      render :show, status: :ok, location: v1_student_url(@v1_student)
    else
      render json: @v1_student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/students/1
  # DELETE /v1/students/1.json
  def destroy
    @v1_student.destroy
  end

  def multi_create
    params.permit!
    p @v1_students = Student.create(params[:students])


    render :index

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_student
      @v1_student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_student_params
      params.fetch(:student, {}).permit(:id, :name, :grade, :phone, :avatar)
    end
end
