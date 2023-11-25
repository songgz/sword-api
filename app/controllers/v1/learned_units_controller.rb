class V1::LearnedUnitsController < ApplicationController
  before_action :set_v1_learned_unit, only: %i[ show update destroy ]

  # GET /v1/learned_units
  # GET /v1/learned_units.json
  def index
    @v1_learned_units = LearnedUnit.all
  end

  # GET /v1/learned_units/1
  # GET /v1/learned_units/1.json
  def show
  end

  # POST /v1/learned_units
  # POST /v1/learned_units.json
  def create
    @v1_learned_unit = LearnedUnit.new(v1_learned_unit_params)

    if @v1_learned_unit.save
      render :show, status: :created, location: @v1_learned_unit
    else
      render json: @v1_learned_unit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/learned_units/1
  # PATCH/PUT /v1/learned_units/1.json
  def update
    if @v1_learned_unit.update(v1_learned_unit_params)
      render :show, status: :ok, location: @v1_learned_unit
    else
      render json: @v1_learned_unit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/learned_units/1
  # DELETE /v1/learned_units/1.json
  def destroy
    @v1_learned_unit.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_learned_unit
      @v1_learned_unit = LearnedUnit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_learned_unit_params
      params.fetch(:v1_learned_unit, {})
    end
end
