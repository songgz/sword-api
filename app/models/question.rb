class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  belongs_to :word
  embedded_in :quiz
  embeds_many :choices
end
