class Student < User
  field :acct_no, type: String, default: -> {gen_rand_no}
  field :register_type, type: String #MASTER_BOSS
  field :grade, type: String, default: ''
  has_many :cards

  #validates :userid, presence: true, uniqueness: true, length: { minimum: 3 }

  def gen_rand_no
    @@num ||= (0..9).to_a
    @@str ||= ('A'..'Z').to_a
    s = @@str.sample(4).join + @@num.sample(6).join
    #c = Card.where(no: s).first
    #s = gen_no if c
    s
  end

end
