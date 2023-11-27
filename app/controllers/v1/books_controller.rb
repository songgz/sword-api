class V1::BooksController < ApplicationController
  before_action :set_v1_book, only: %i[ show update destroy ]

  # GET /v1/books
  # GET /v1/books.json
  def index
    opts = {
      kind: params[:kind],
      category: params[:category]
    }.delete_if { |k, v| v.blank?}
    @v1_books = Book.where(opts).page(params[:page]).per(params[:per])
    @pagination = pagination(@v1_books)
  end

  # GET /v1/books/1
  # GET /v1/books/1.json
  def show
  end

  # POST /v1/books
  # POST /v1/books.json
  def create
    @v1_book = V1::Book.new(v1_book_params)

    if @v1_book.save
      render :show, status: :created, location: @v1_book
    else
      render json: @v1_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/books/1
  # PATCH/PUT /v1/books/1.json
  def update
    if @v1_book.update(v1_book_params)
      render :show, status: :ok, location: @v1_book
    else
      render json: @v1_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/books/1
  # DELETE /v1/books/1.json
  def destroy
    @v1_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_book
      @v1_book = V1::Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_book_params
      params.fetch(:v1_book, {})
    end
end
