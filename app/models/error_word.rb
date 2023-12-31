class ErrorWord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :repeats, type: Integer, default: 0
  field :learns, type: Integer, default: 0
  field :reviews, type: Integer, default: 0

  belongs_to :unit
  belongs_to :dictionary
  embedded_in :learned_book
end
