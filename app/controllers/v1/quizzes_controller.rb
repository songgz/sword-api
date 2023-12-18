class V1::QuizzesController < ApplicationController
  before_action :set_v1_quiz, only: %i[ show update destroy ]

  # GET /v1/quizzes
  # GET /v1/quizzes.json
  def index
    @v1_quizzes = Quiz.all
  end

  # GET /v1/quizzes/1
  # GET /v1/quizzes/1.json
  def show
    p @v1_quiz
  end

  # POST /v1/quizzes
  # POST /v1/quizzes.json
  def create
    opts = {
      student_id: v1_quiz_params[:student_id].to_s,
      unit_id: v1_quiz_params[:unit_id].to_s,
      test_type: v1_quiz_params[:test_type].to_s,
      learn_type: v1_quiz_params[:learn_type].to_s
    }
    @v1_quiz = Quiz.find_or_create_by(opts)

    if @v1_quiz
      render :show, status: :created  #, location: v1_quiz_url(@v1_quiz)
    else
      render json: @v1_quiz.errors, status: :unprocessableentity
    end
  end

  # PATCH/PUT /v1/quizzes/1
  # PATCH/PUT /v1/quizzes/1.json
  def update
    puts params.inspect
    puts v1_quiz_params.inspect

    v1_quiz_params[:questions].each do |updated_question|
      question = @v1_quiz.questions.detect { |q| q.id.to_s == updated_question[:id].to_s }
      if question
        question.user_answer = updated_question[:user_answer]
        question.result = updated_question[:result]
      end
    end

    if @v1_quiz.update({corrects: v1_quiz_params[:corrects],
                        wrongs: v1_quiz_params[:wrongs],
                        score: v1_quiz_params[:score],
                        duration: v1_quiz_params[:duration]
                       })
      render :show, status: :ok, location: v1_quiz_url(@v1_quiz)
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
      params.fetch(:quiz, {}).permit(:id, :unit_id, :student_id, :test_type, :learn_type, :corrects, :wrongs, :score, :duration, questions: [:id,:user_answer,:result])
    end
end
