class V1::TeachersController < ApplicationController
  before_action :set_v1_teacher, only: %i[ show update destroy ]

  # GET /v1/teachers
  # GET /v1/teachers.json
  def index
    opts = {}
    opts[:name] = /.*#{params[:key]}.*/i if params[:key].present?
    @v1_teachers = Teacher.where(opts).page(params[:page]).per(params[:pre])
    @pagination = pagination(@v1_teachers)
  end

  # GET /v1/teachers/1
  # GET /v1/teachers/1.json
  def show
  end

  # POST /v1/teachers
  # POST /v1/teachers.json
  def create
    @v1_teacher = Teacher.new(v1_teacher_params)

    if @v1_teacher.save
      render :show, status: :created, location: v1_teacher_url(@v1_teacher)
    else
      render json: @v1_teacher.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/teachers/1
  # PATCH/PUT /v1/teachers/1.json
  def update
    if @v1_teacher.update(v1_teacher_params)
      render :show, status: :ok, location: v1_teacher_url(@v1_teacher)
    else
      render json: @v1_teacher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/teachers/1
  # DELETE /v1/teachers/1.json
  def destroy
    @v1_teacher.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_teacher
      @v1_teacher = Teacher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_teacher_params
      params.fetch(:teacher, {}).permit(:id, :name, :gender, :age, :avatar, :email)
    end
end
