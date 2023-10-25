class Quiz
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :test_type, type: String
  belongs_to :unit
  belongs_to :user
  embeds_many :questions

  validates :user_id, uniqueness: {scope: [:unit_id]}

  set_callback(:initialize, :after) do |document|
    generate if questions.blank?
  end

  def generate
    words = unit.words.to_a
    words.sample(20).each do |word|
      questions.build(word: word, title: word.word) do |question|
        ws = words.sample(3)
        ws << word
        ws.sample(4).each do |w|
          question.choices.build(word: w, title: w.acceptation)
        end
      end
    end
  end
end
