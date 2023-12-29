class Word
  include Mongoid::Document
  include Mongoid::Timestamps

  field :book_category, type: String
  field :word, type: String
  field :unit_name, type: String
  field :book_name, type: String

  belongs_to :book, optional: true
  belongs_to :unit, optional: true
  belongs_to :dictionary, optional: true

end
