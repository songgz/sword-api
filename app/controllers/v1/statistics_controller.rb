class V1::StatisticsController < ApplicationController
  before_action :set_v1_statistic, only: %i[ show update destroy ]

  # GET /v1/statistics
  # GET /v1/statistics.json
  def index
    @v1_statistics = V1::LearnedWord.all
  end

  # GET /v1/statistics/1
  # GET /v1/statistics/1.json
  def show
  end

  # POST /v1/statistics
  # POST /v1/statistics.json
  def create
    @v1_statistic = V1::LearnedWord.new(v1_statistic_params)

    if @v1_statistic.save
      render :show, status: :created, location: @v1_statistic
    else
      render json: @v1_statistic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/statistics/1
  # PATCH/PUT /v1/statistics/1.json
  def update
    if @v1_statistic.update(v1_statistic_params)
      render :show, status: :ok, location: @v1_statistic
    else
      render json: @v1_statistic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/statistics/1
  # DELETE /v1/statistics/1.json
  def destroy
    @v1_statistic.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_statistic
      @v1_statistic = V1::LearnedWord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_statistic_params
      params.fetch(:v1_statistic, {})
    end
end
