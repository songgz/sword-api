class V1::SchoolsController < ApplicationController
  before_action :set_v1_school, only: %i[ show update destroy ]

  # GET /v1/schools
  # GET /v1/schools.json
  def index
    opts = {}
    opts[:name] = /.*#{params[:key]}.*/i if params[:key].present?
    @v1_schools = School.where(opts).page(params[:page]).per(params[:pre])
    @pagination = pagination(@v1_schools)
  end

  # GET /v1/schools/1
  # GET /v1/schools/1.json
  def show
  end

  # POST /v1/schools
  # POST /v1/schools.json
  def create
    @v1_school = School.new(v1_school_params)

    if @v1_school.save
      render :show, status: :created, location: v1_school_url(@v1_school)
    else
      render json: @v1_school.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/schools/1
  # PATCH/PUT /v1/schools/1.json
  def update
    if @v1_school.update(v1_school_params)
      render :show, status: :ok, location: v1_school_url(@v1_school)
    else
      render json: @v1_school.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/schools/1
  # DELETE /v1/schools/1.json
  def destroy
    @v1_school.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_school
      @v1_school = School.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_school_params
      params.fetch(:school, {}).permit(:id, :name, :city_code, :address, :master_name, :master_mobile)
    end
end
