class LearnedUnit
  include Mongoid::Document
  include Mongoid::Timestamps

  field :progress, type: Float, default: 0.0
  field :learns, type: Integer, default: 0
  field :wrongs, type: Integer, default: 0
  field :words, type: Integer, default: 0
  field :unit_name, type: String, default: ''
  field :last_word_index, type: Integer, default: 0

  belongs_to :unit, optional: true
  embedded_in :learned_book

end
