class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :user_answer
  field :right_answer
  field :result, type: Boolean, default: false

  belongs_to :word, optional: true
  embedded_in :quiz
  embeds_many :choices

end
