class LearnedUnit
  include Mongoid::Document
  include Mongoid::Timestamps

  field :completions, type: Integer, default: 0
  field :wrongs, type: Integer, default: 0
  field :rights, type: Integer, default: 0
  field :total, type: Integer, default: 0
  field :unit_name, type: String, default: ''
  field :last_word_index, type: Integer, default: 0

  belongs_to :unit, optional: true
  embedded_in :learned_book

end
