class Unit
  include Mongoid::Document
  include Mongoid::Timestamps
  field :book_no, type: String
  field :no, type: String
  field :name, type: String
  field :desc, type: String
  field :word_count, type: Integer
  field :status, type: String
  field :seq, type: Integer
  field :my_id, type: Integer
  field :my_word_nos, type: Array, default: []

  belongs_to :book
  has_and_belongs_to_many :words, inverse_of: nil

  def book_name
    book.name
  end

end
