class ErrorWord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :repeats, type: Integer, default: 0
  field :learns, type: Integer, default: 0
  field :reviews, type: Integer, default: 0
  field :is_wrong, type: Boolean, default: false

  belongs_to :unit
  belongs_to :word
  embedded_in :learned_book
end
