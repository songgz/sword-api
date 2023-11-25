class ErrorWord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :error_num, type: Integer, default: 0
  field :learn_num, type: Integer, default: 0
  field :review_num, type: Integer, default: 0

  belongs_to :word
  embedded_in :learned_unit
end
