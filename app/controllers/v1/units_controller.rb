class V1::UnitsController < ApplicationController
  before_action :set_v1_unit, only: %i[ show update destroy ]

  # GET /v1/units
  # GET /v1/units.json
  def index
    opts = {
      book_id: params[:book_id]
    }.delete_if { |k, v| v.blank? }

    @v1_units = paginate(Unit.where(opts).order(seq: 1)) #.page(params[:page]).per(params[:per])

  end

  # GET /v1/units/1
  # GET /v1/units/1.json
  def show
  end

  # POST /v1/units
  # POST /v1/units.json
  def create
    @v1_unit = Unit.new(v1_unit_params)

    if @v1_unit.save
      render :show, status: :created, location: @v1_unit
    else
      render json: @v1_unit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/units/1
  # PATCH/PUT /v1/units/1.json
  def update
    if @v1_unit.update(v1_unit_params)
      render :show, status: :ok, location: @v1_unit
    else
      render json: @v1_unit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/units/1
  # DELETE /v1/units/1.json
  def destroy
    @v1_unit.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_unit
      @v1_unit = Unit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_unit_params
      params.fetch(:v1_unit, {}).permit(:book_id)
    end
end
