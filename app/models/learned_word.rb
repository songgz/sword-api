class LearnedWord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :day, type: Date
  #field :erred, type: Boolean, default: false
  field :duration, type: Integer, default: 0
  #field :word, type: String, default: ''
  #field :repeats, type: Integer, default: 0
  #field :reviews, type: Integer, default: 0

  belongs_to :student, optional: true
  belongs_to :book, optional: true
  belongs_to :unit, optional: true
  belongs_to :dictionary, optional: true

end
