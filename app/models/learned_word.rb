class LearnedWord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :day, type: Date
  field :durations, type: Integer, default: 0
  field :completions, type: Integer, default: 0
  field :reviews, type: Integer, default: 0

  belongs_to :student, optional: true

  index({ student_id: 1, day: 1 })
end
