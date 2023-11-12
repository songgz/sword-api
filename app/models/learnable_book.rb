class LearnableBook
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :student, optional: true
  has_and_belongs_to_many :books, inverse_of: nil
end
