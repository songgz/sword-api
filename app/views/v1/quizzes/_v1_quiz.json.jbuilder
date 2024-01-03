json.extract! v1_quiz, :id, :test_type, :learn_type, :title, :book_name, :unit_name, :unit_id, :student_id, :corrects, :wrongs, :total, :score, :duration, :created_at, :updated_at
json.questions v1_quiz.questions, :id,:title do |question|
  json.extract! question, :id, :dictionary_id, :title, :right_answer, :user_answer, :result
  json.choices question.choices, :dictionary_id, :title, :id
end
#json.url v1_quiz_url(v1_quiz, format: :json)
