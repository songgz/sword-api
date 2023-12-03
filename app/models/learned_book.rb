class LearnedBook
  include Mongoid::Document
  include Mongoid::Timestamps

  field :progress, type: Float, default: 0.0
  field :rights, type: Integer, default: 0
  field :wrongs, type: Integer, default: 0
  field :learn_type, type: String, default: ''

  belongs_to :student
  belongs_to :book
  embeds_many :learned_units
  embeds_many :error_words

  set_callback(:create, :before) do |doc|
    doc.make_units
  end



  def make_units
    book.units.each do |u|
      learned_units.build(unit_id: u.id, unit_name: u.name, words: u.word_count)
    end
  end

  def calc
    es = error_words.map { |w| [w.unit_id, w]}.to_h
  end
end
