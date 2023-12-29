class V1::DictionariesController < ApplicationController
  before_action :set_v1_dictionary, only: %i[ show update destroy ]

  # GET /v1/dictionaries
  # GET /v1/dictionaries.json
  def index
    @v1_dictionaries = Dictionary.all
    @v1_dictionaries = @v1_dictionaries.order(id: :desc).page(params[:page]).per(params[:per])
    @pagination = pagination(@v1_dictionaries)
  end

  # GET /v1/dictionaries/1
  # GET /v1/dictionaries/1.json
  def show
  end

  # POST /v1/dictionaries
  # POST /v1/dictionaries.json
  def create
    @v1_dictionary = Dictionary.new(v1_dictionary_params)

    if @v1_dictionary.save
      render :show, status: :created, location: @v1_dictionary
    else
      render json: @v1_dictionary.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/dictionaries/1
  # PATCH/PUT /v1/dictionaries/1.json
  def update
    if @v1_dictionary.update(v1_dictionary_params)
      render :show, status: :ok, location: @v1_dictionary
    else
      render json: @v1_dictionary.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/dictionaries/1
  # DELETE /v1/dictionaries/1.json
  def destroy
    @v1_dictionary.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_dictionary
      @v1_dictionary = Dictionary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_dictionary_params
      params.fetch(:v1_dictionary, {})
    end
end
