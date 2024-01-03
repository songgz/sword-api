class LearnedWord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :day, type: Date
  field :duration, type: Integer, default: 0

  belongs_to :student, optional: true
  belongs_to :book, optional: true
  belongs_to :unit, optional: true
  belongs_to :dictionary, optional: true

  index({ day: 1 })
end
