class Teacher < User
  field :age, type: Integer
  field :email, type: String, default: ''
  field :gender, type: String, default: :male

  has_many :students

end
