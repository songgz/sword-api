class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword
  include Mongoid::Search

  field :name, type: String
  field :avatar, type: String, default: ''
  field :phone, type: String, default: ''
  field :salt, type: String, default: ''
  field :password_digest, type: String
  field :acct_no, type: String, default: -> {gen_rand_no}

  field :birthday, type: Date
  field :wechat, type: String, default: ''

  belongs_to :school, optional: true

  search_in :name, :phone, :acct_no

  has_secure_password

  def gen_rand_no
    @@num ||= (0..9).to_a
    @@str ||= ('A'..'Z').to_a
    s = @@str.sample(4).join + @@num.sample(6).join
    #c = Card.where(no: s).first
    #s = gen_no if c
    s
  end




  set_callback(:initialize, :after) do |doc|
    doc.password = '123456'
  end


end
