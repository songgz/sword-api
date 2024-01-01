class ErrorWord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :repeats, type: Integer, default: 0
  field :learns, type: Integer, default: 0
  field :reviews, type: Integer, default: 0

  belongs_to :unit, optional: true
  belongs_to :dictionary, optional: true
  embedded_in :learned_book
end
