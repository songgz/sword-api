class V1::LearnedBooksController < ApplicationController
  before_action :set_v1_learned_book, only: %i[ show update destroy ]

  # GET /v1/learned_books
  # GET /v1/learned_books.json
  def index
    @v1_learned_books = LearnedBook.all
  end

  # GET /v1/learned_books/1
  # GET /v1/learned_books/1.json
  def show
  end

  # POST /v1/learned_books
  # POST /v1/learned_books.json
  def create
    @v1_learned_book = LearnedBook.new(v1_learned_book_params)

    if @v1_learned_book.save
      render :show, status: :created, location: @v1_learned_book
    else
      render json: @v1_learned_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/learned_books/1
  # PATCH/PUT /v1/learned_books/1.json
  def update
    if @v1_learned_book.update(v1_learned_book_params)
      render :show, status: :ok, location: @v1_learned_book
    else
      render json: @v1_learned_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/learned_books/1
  # DELETE /v1/learned_books/1.json
  def destroy
    @v1_learned_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_learned_book
      @v1_learned_book = LearnedBook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_learned_book_params
      params.fetch(:v1_learned_book, {})
    end
end
