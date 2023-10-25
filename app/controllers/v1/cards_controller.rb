class V1::CardsController < ApplicationController
  before_action :set_v1_card, only: %i[ show update destroy ]

  # GET /v1/cards
  # GET /v1/cards.json
  def index
    @v1_cards = Card.all.page(params[:page]).per(params[:pre])
    @pagination = pagination(@v1_cards)
  end

  # GET /v1/cards/1
  # GET /v1/cards/1.json
  def show
  end

  # POST /v1/cards
  # POST /v1/cards.json
  def create
    @v1_card = Card.new(v1_card_params)

    if @v1_card.save
      render :show, status: :created, location: @v1_card
    else
      render json: @v1_card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/cards/1
  # PATCH/PUT /v1/cards/1.json
  def update
    if @v1_card.update(v1_card_params)
      render :show, status: :ok, location: @v1_card
    else
      render json: @v1_card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/cards/1
  # DELETE /v1/cards/1.json
  def destroy
    @v1_card.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_card
      @v1_card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_card_params
      params.fetch(:v1_card, {}).permit(:id, :no, :kind, :days, :school_id, :student_id)
    end
end
