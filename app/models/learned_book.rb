class LearnedBook
  include Mongoid::Document
  include Mongoid::Timestamps

  field :progress, type: Float
  field :right_num, type: Integer
  field :error_num, type: Integer

  belongs_to :student
  belongs_to :book
  has_many :learned_units
end
