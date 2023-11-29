class Quiz
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :test_type, type: String
  field :unit_name, type: String
  field :corrects, type: Integer, default: 0
  field :wrongs, type: Integer, default: 0
  field :total, type: Integer, default: 0
  field :score, type: Float, default: 0.0
  field :duration, type: Integer, default: 0

  belongs_to :unit
  belongs_to :student
  embeds_many :questions

  validates :student_id, uniqueness: {scope: [:unit_id]}

  set_callback(:initialize, :after) do |doc|
    generate if questions.blank?
  end

  set_callback(:save, :before) do |doc|
    doc.unit_name = doc.unit.name
  end

  def generate
    total = 20
    words = unit.words.to_a
    words.sample(total).each do |word|
      questions.build(word: word, title: word.word) do |question|
        ws = words.sample(3)
        ws << word
        ws.sample(4).each do |w|
          c = Choice.new(word: w, title: w.acceptation)
          question.choices << c
          if c.word == word
            question.right_answer = c.id
          end
        end
      end
    end
  end
end
