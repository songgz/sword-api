class Choice
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  belongs_to :word, optional: true
  embedded_in :quiz
end
