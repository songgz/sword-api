json.extract! v1_quiz, :id, :test_type, :unit_name, :unit_id, :student_id, :corrects, :wrongs, :total, :score, :duration, :created_at, :updated_at
json.questions v1_quiz.questions, :id,:title do |question|
  json.extract! question, :word_id, :title, :right_answer, :user_answer, :result
  json.choices question.choices, :word_id, :title, :id
end
#json.url v1_quiz_url(v1_quiz, format: :json)
