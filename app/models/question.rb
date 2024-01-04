class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :user_answer
  field :right_answer
  field :result, type: Boolean, default: false
  field :pronunciation, type: String #读音

  belongs_to :dictionary, optional: true
  embedded_in :quiz
  embeds_many :choices
end
