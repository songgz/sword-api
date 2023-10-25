class Choice
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  belongs_to :word
  embedded_in :quiz
end
