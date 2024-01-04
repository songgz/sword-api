class Quiz
  include Mongoid::Document
  include Mongoid::Timestamps
  TEST_TYPES = {beforeLearn: '学前测试', afterLearn: '学后测试'}
  LEARN_TYPES = {read: '认读', listen: '辨音', spell: '拼写'}

  field :title, type: String
  field :unit_name, type: String
  field :book_name, type: String
  field :corrects, type: Integer, default: 0
  field :wrongs, type: Integer, default: 0
  field :total, type: Integer, default: 20
  field :score, type: Float, default: 0.0
  field :duration, type: Integer, default: 0
  field :learn_type, type: String
  field :test_type, type: String

  belongs_to :book, optional: true
  belongs_to :unit, optional: true
  belongs_to :student
  embeds_many :questions

  validates :student_id, uniqueness: {scope: [:unit_id, :test_type, :learn_type]}

  def learned_unit
    lb = LearnedBook.where({book_id: self.book_id, student_id:self.student_id, learn_type: self.learn_type}).first
    if lb
      return lu = lb.learned_units.detect {|u| u.unit_id == self.unit_id}
    end
  end

  set_callback(:initialize, :after) do |doc|
    #generate if questions.blank?
  end

  set_callback(:create, :before) do |doc|
    doc.unit_name = doc.unit.name
    doc.book = doc.unit.book
    doc.book_name = doc.unit.book&.name
    doc.title = "#{doc.book_name}.#{doc.unit_name} #{Quiz::LEARN_TYPES[doc.learn_type.to_sym]} #{Quiz::TEST_TYPES[doc.test_type.to_sym]}"
    doc.generate
  end

  def generate
    words = unit.words.map {|w| w.dictionary}
    words.sample(total).each do |word|
      questions.build(dictionary: word, title: word.word, pronunciation: word.pronunciation) do |question|
        if self.learn_type != 'spell'
          ws = words.reject { |o| o.id == word.id}.sample(3)
          ws << word
          ws.shuffle.each do |w|
            c = Choice.new(dictionary: w, title: w.acceptation)
            question.choices << c
            if c.dictionary == word
              question.right_answer = c.id
            end
          end
        end
      end
    end
  end
end
