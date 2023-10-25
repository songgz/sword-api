class V1::WordsController < ApplicationController
  before_action :set_v1_word, only: %i[ show update destroy ]

  # GET /v1/words
  # GET /v1/words.json
  def index

    if params[:unit_id].blank?
      opts = {

      }.delete_if { |k, v| v.blank? }
      @v1_words = paginate(Word.where(opts))
    else
      @v1_words = Unit.find_by(id: params[:unit_id]).words

    end

  end

  # GET /v1/words/1
  # GET /v1/words/1.json
  def show
  end

  # POST /v1/words
  # POST /v1/words.json
  def create
    @v1_word = Word.new(v1_word_params)

    if @v1_word.save
      render :show, status: :created, location: @v1_word
    else
      render json: @v1_word.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/words/1
  # PATCH/PUT /v1/words/1.json
  def update
    if @v1_word.update(v1_word_params)
      render :show, status: :ok, location: @v1_word
    else
      render json: @v1_word.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/words/1
  # DELETE /v1/words/1.json
  def destroy
    @v1_word.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_word
      @v1_word = Word.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_word_params
      params.fetch(:v1_word, {})
    end
end
