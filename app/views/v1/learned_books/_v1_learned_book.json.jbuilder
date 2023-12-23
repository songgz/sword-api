json.extract! v1_learned_book, :id, :student_id, :book_id, :learn_type, :progress, :total, :completions, :rights, :wrongs, :created_at, :updated_at
json.learned_units v1_learned_book.learned_units, :id, :unit_id, :unit_name, :last_word_index, :completions, :rights, :wrongs, :total, :before_learn_quiz, :after_learn_quiz
json.error_words v1_learned_book.error_words do |eb|
  json.(eb, :id, :unit_id, :word_id, :repeats, :learns, :reviews)
  json.word @er_words[eb.word_id], :id, :book_category, :word, :phonetic_symbol, :acceptation, :example, :picture, :parse, :pronunciation, :usage if @er_words
end
json.book v1_learned_book.book, :id, :name, :kind, :category, :cover
#json.url v1_learned_book_url(v1_learned_book, format: :json)
