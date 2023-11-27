json.extract! v1_learned_book, :id, :student_id, :book_id, :progress, :rights, :wrongs, :created_at, :updated_at
json.learned_units v1_learned_book.learned_units, :id, :unit_id, :progress, :rights, :wrongs, :words
json.error_words v1_learned_book.error_words, :id, :word_id, :repeats, :learns, :reviews
#json.url v1_learned_book_url(v1_learned_book, format: :json)
