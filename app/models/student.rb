class Student < User

  field :register_type, type: String #MASTER_BOSS
  field :grade, type: String, default: ''
  has_many :cards

  #validates :userid, presence: true, uniqueness: true, length: { minimum: 3 }



end
