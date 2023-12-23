class LearnedBook
  include Mongoid::Document
  include Mongoid::Timestamps

  field :progress, type: Float, default: 0.0
  field :total, type: Integer, default: 0
  field :completions, type: Integer, default: 0
  field :rights, type: Integer, default: 0
  field :wrongs, type: Integer, default: 0
  field :learn_type, type: String, default: ''

  belongs_to :student
  belongs_to :book
  embeds_many :learned_units
  embeds_many :error_words

  set_callback(:create, :before) do |doc|
    doc.total = doc.book.word_count
    doc.make_units
  end

  def make_units
    book.units.each do |u|
      learned_units.build(unit_id: u.id, unit_name: u.name, total: u.word_count)
    end
  end
  #sword@123

  set_callback(:save, :before) do |doc|
    doc.completions = 0
    doc.rights = 0
    doc.wrongs = 0
    doc.learned_units.each do |u|
      doc.completions += u.completions
      doc.rights += u.rights
      doc.wrongs += u.wrongs
    end
    doc.progress = (doc.completions.to_f / doc.total.to_f).round(2) if doc.total > 0
  end

  def calc
    es = error_words.map { |w| [w.unit_id, w]}.to_h
  end
end
