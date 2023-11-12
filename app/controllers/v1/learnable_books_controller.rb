class V1::LearnableBooksController < ApplicationController
  before_action :set_v1_learnable_book, only: %i[ show update destroy ]

  # GET /v1/learnable_books
  # GET /v1/learnable_books.json
  def index
    opts = {
      student_id: params[:student_id]
    }.delete_if { |k, v| v.blank? }
    @v1_learnable_books = LearnableBook.where(opts)
  end

  # GET /v1/learnable_books/1
  # GET /v1/learnable_books/1.json
  def show
  end

  # POST /v1/learnable_books
  # POST /v1/learnable_books.json
  def create
    @v1_learnable_book = LearnableBook.find_or_initialize_by(student_id: v1_learnable_book_params[:student_id])
    @v1_learnable_book.book_ids = v1_learnable_book_params[:book_ids]

    if @v1_learnable_book.save
      render :show, status: :created, location: v1_learnable_book_url(@v1_learnable_book)
    else
      render json: @v1_learnable_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/learnable_books/1
  # PATCH/PUT /v1/learnable_books/1.json
  def update
    if @v1_learnable_book.update(v1_learnable_book_params)
      render :show, status: :ok, location: @v1_learnable_book
    else
      render json: @v1_learnable_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/learnable_books/1
  # DELETE /v1/learnable_books/1.json
  def destroy
    @v1_learnable_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_learnable_book
      @v1_learnable_book = LearnableBook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_learnable_book_params
      params.fetch(:learnable_book, {}).permit!
    end
end
