json.extract! v1_word, :id, :book_id, :book_name, :unit_id, :unit_name, :dictionary_id, :created_at, :updated_at
json.dictionary v1_word.dictionary, :id, :book_category, :word, :phonetic_symbol, :acceptation, :example, :picture, :parse, :pronunciation, :usage, :status
#json.url v1_word_url(v1_word, format: :json)
