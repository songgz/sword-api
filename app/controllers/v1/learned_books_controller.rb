class V1::LearnedBooksController < ApplicationController
  before_action :set_v1_learned_book, only: %i[ update destroy ]

  # GET /v1/learned_books
  # GET /v1/learned_books.json
  def index
    opts = {
      kind: params[:kind],
      category: params[:category],
      student_id: params[:student_id]
    }.delete_if { |k, v| v.blank?}
    @v1_learned_books = LearnedBook.includes(:book).where(opts).page(params[:page]).per(params[:per])
    @pagination = pagination(@v1_learned_books)

  end

  # GET /v1/learned_books/1
  # GET /v1/learned_books/1.json
  def show
    @v1_learned_book = LearnedBook.find_by(student_id: params[:student_id], book_id: params[:book_id])
    eb_ids = @v1_learned_book.error_words.map(&:word_id)
    @er_words = Word.in(id: eb_ids).map { |w| [w.id, w] }.to_h
  end

  # POST /v1/learned_books
  # POST /v1/learned_books.json
  def create
    @v1_learned_book = LearnedBook.find_or_create_by({student_id: v1_learned_book_params[:student_id], book_id: v1_learned_book_params[:book_id]})



    if @v1_learned_book.save
      render :show, status: :created, location: v1_learned_books_url(@v1_learned_book)
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
      params.fetch(:learned_book, {}).permit(:student_id, :book_id)
    end
end
