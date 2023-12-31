class V1::LearnedBooksController < ApplicationController
  before_action :set_v1_learned_book, only: %i[update destroy ]

  # GET /v1/learned_books
  # GET /v1/learned_books.json
  def index
    opts = {
      kind: params[:kind],
      category: params[:category],
      student_id: params[:student_id],
      learn_type: params[:learn_type]
    }.delete_if { |k, v| v.blank? }
    @v1_learned_books = LearnedBook.includes(:book).where(opts).page(params[:page]).per(params[:per])
    @pagination = pagination(@v1_learned_books)

  end

  # GET /v1/learned_books/1
  # GET /v1/learned_books/1.json
  def show
    @v1_learned_book = LearnedBook.find_by({
                                             student_id: params[:student_id],
                                             book_id: params[:book_id],
                                             learn_type: params[:learn_type]
                                           })
    eb_ids = @v1_learned_book.error_words.map(&:dictionary_id)
    @dictionaries = Dictionary.in(id: eb_ids).map { |w| [w.id, w] }.to_h
  end

  # POST /v1/learned_books
  # POST /v1/learned_books.json
  def create
    params.permit!
    service = BookSelectionService.new(params[:student_id], params[:book_id])

    if service.perform
      render json: :ok, status: :created
    else
      render json: { messages: service.errors.full_messages }, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /v1/learned_books/1
  # PATCH/PUT /v1/learned_books/1.json
  def update
    puts params.inspect
    puts v1_learned_book_params.inspect

    v1_learned_book_params[:learned_units].each do |updated_learned_unit|
      learned_unit = @v1_learned_book.learned_units.detect { |u| u.id.to_s == updated_learned_unit[:id].to_s }
      if learned_unit
        learned_unit.completions = updated_learned_unit[:completions]
        learned_unit.rights = updated_learned_unit[:rights]
        learned_unit.wrongs = updated_learned_unit[:wrongs]
        learned_unit.last_word_index = updated_learned_unit[:last_word_index]
      end
    end

    v1_learned_book_params[:error_words].each do |updated_error_word|
      error_word = @v1_learned_book.error_words.detect { |u| u.dictionary_id.to_s == updated_error_word[:dictionary_id].to_s && u.unit_id.to_s == updated_error_word[:unit_id].to_s }
      if error_word
        error_word.repeats = updated_error_word[:repeats]
        error_word.learns = updated_error_word[:learns]
        error_word.reviews = updated_error_word[:reviews]
      else
        p updated_error_word
        p @v1_learned_book.error_words.build(updated_error_word.to_h)
      end
    end

    v1_learned_book_params[:learned_words].each do |updated_learned_word|
      lw = LearnedWord.find_or_initialize_by({
                                               day: Date.today,
                                               student_id: updated_learned_word[:student_id],
                                               book_id: updated_learned_word[:book_id],
                                               unit_id: updated_learned_word[:unit_id],
                                               dictionary_id: updated_learned_word[:dictionary_id]
                                             })
      lw.duration += updated_learned_word[:duration]
      lw.save
    end

    p @v1_learned_book.errors

    if @v1_learned_book.save
      render :show, status: :created, location: v1_learned_books_url(@v1_learned_book)
    else
      render json: @v1_learned_book.errors, status: :unprocessable_entity
    end

    # if @v1_learned_book.update(v1_learned_book_params)
    #   render :show, status: :ok, location: @v1_learned_book
    # else
    #   render json: @v1_learned_book.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /v1/learned_books/1
  # DELETE /v1/learned_books/1.json
  def destroy
    params.permit!
    @v1_learned_book.error_words.where(unit_id: params[:learned_unit_id].to_s).delete
    learned_unit = @v1_learned_book.learned_units.detect { |u| u.id.to_s == params[:learned_unit_id].to_s }
    learned_unit.completions = 0
    learned_unit.rights = 0
    learned_unit.wrongs = 0
    learned_unit.last_word_index = 0
    @v1_learned_book.save
    render json: @v1_learned_book.errors, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_v1_learned_book
    @v1_learned_book = LearnedBook.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def v1_learned_book_params
    params.fetch(:learned_book, {}).permit(:id,:student_id, :book_id, :learn_type, :total, :before_learn_quiz, :after_learn_quiz,
      error_words: [:unit_id, :dictionary_id, :repeats, :learns, :reviews],
                                           learned_units: [:id, :unit_id, :unit_name, :completions, :rights, :wrongs, :last_word_index],
                                           learned_words: [:student_id, :book_id, :unit_id, :dictionary_id, :duration])
  end
end
