class LearnedBook
  include Mongoid::Document
  include Mongoid::Timestamps

  field :progress, type: Float, default: 0.0
  field :rights, type: Integer, default: 0
  field :wrongs, type: Integer, default: 0

  belongs_to :student
  belongs_to :book
  embeds_many :learned_units
  embeds_many :error_words
end
