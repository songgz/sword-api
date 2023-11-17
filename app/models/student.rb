class Student < User

  field :acct_no, type: String, default: -> {gen_rand_no}
  field :register_type, type: String #MASTER_BOSS
  field :grade, type: String, default: ''
  field :vip_expiration_time, type: DateTime
  has_many :cards
  belongs_to :teacher, optional: true

  def recharge(card_password)
    card = Card.where(status: 'UNUSED', card_no: /.*#{card_password}/).first
    errors.add(:base, :invalid, message: "非法充值卡，不能充值。") if card.blank?
    errors.add(:base, :invalid, message: "VIP未到期，不能充值。") if self.vip_expiration_time > DateTime.now

    if errors.empty?
      card.active(self)
      self.vip_expiration_time = card.active_time + card.days.day
      return save
    end
    return false
  end

  def vip_status
    self.vip_expiration_time < DateTime.now
  end

  def gen_rand_no
    @@num ||= (0..9).to_a
    @@str ||= ('A'..'Z').to_a
    s = @@str.sample(4).join + @@num.sample(6).join
    #c = Card.where(no: s).first
    #s = gen_no if c
    s
  end







  #validates :userid, presence: true, uniqueness: true, length: { minimum: 3 }



end
