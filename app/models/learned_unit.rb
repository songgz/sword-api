class LearnedUnit
  include Mongoid::Document
  include Mongoid::Timestamps

  field :progress, type: Float
  field :right_num, type: Integer
  field :error_num, type: Integer

  belongs_to :student
  belongs_to :unit
  belongs_to :learned_book, optional: true
  embeds_many :error_words
end
