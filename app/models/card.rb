class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search

  field :card_no, type: String, default: -> {gen_rand_no}
  field :kind, type: String, default: 'HALF_YEAR' #HALF_YEAR
  field :days, type: Integer, default: 180 #180
  field :student_name, type: String
  field :student_acct_no, type: String #3036242 924555
  field :active_time, type: DateTime
  field :status, type: String #USED
  field :school_name, type: String

  belongs_to :school, optional: true
  belongs_to :student, optional: true

  search_in :card_no, :school_name, :student_name, :student_acct_no

  set_callback(:initialize, :after) do |doc|
    if doc.student_id_changed?
      doc.student_name = doc.student.name
      doc.student_acct_no = doc.student.acct_no
    end
    if doc.school_id_changed?
      doc.school_name = doc.school&.name
    end

  end



  def gen_rand_no
    @@num ||= (0..9).to_a
    @@str ||= ('A'..'Z').to_a
    s = @@str.sample(4).join + @@num.sample(6).join
    #c = Card.where(no: s).first
    #s = gen_no if c
    s
  end

end
