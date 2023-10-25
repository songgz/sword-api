class Teacher < User
  field :age, type: Integer
  field :email, type: String, default: ''
  field :gender, type: String, default: :male

end
