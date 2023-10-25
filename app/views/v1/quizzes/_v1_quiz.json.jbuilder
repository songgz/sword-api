json.extract! v1_quiz, :id, :created_at, :updated_at
json.questions v1_quiz.questions, :id,:title do |question|
  json.extract! question, :word_id, :title
  json.choices question.choices, :word_id, :title
end
#json.url v1_quiz_url(v1_quiz, format: :json)
