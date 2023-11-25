class V1::QuizzesController < ApplicationController
  #before_action :set_v1_quiz, only: %i[ show update destroy ]

  # GET /v1/quizzes
  # GET /v1/quizzes.json
  def index
    @v1_quizzes = Quiz.all
  end

  # GET /v1/quizzes/1
  # GET /v1/quizzes/1.json
  def show
    p 'sssfff'
  end

  # POST /v1/quizzes
  # POST /v1/quizzes.json
  def create
    @v1_quiz = Quiz.find_or_create_by(v1_quiz_params.to_h)

    if @v1_quiz
      render :show, status: :created, location: v1_quiz_url(@v1_quiz)
    else
      render json: @v1_quiz.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/quizzes/1
  # PATCH/PUT /v1/quizzes/1.json
  def update
    if @v1_quiz.update(v1_quiz_params)
      render :show, status: :ok, location: @v1_quiz
    else
      render json: @v1_quiz.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/quizzes/1
  # DELETE /v1/quizzes/1.json
  def destroy
    @v1_quiz.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_quiz
      @v1_quiz = Quiz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_quiz_params
      params.fetch(:quiz, {}).permit(:unit_id, :student_id)
    end
end
