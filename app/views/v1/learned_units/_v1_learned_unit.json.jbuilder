json.extract! v1_learned_unit, :id, :student_id, :unit_id, :created_at, :updated_at
json.error_words v1_learned_unit.error_words, :id,:word_id, :error_num, :learn_num, :review_num