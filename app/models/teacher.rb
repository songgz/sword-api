class Teacher < User
  field :age, type: Integer
  field :email, type: String, default: ''
  field :gender, type: String, default: :male

  has_many :students

  set_callback(:create, :before) do |doc|
    doc.password = doc.phone[-6..]
    doc.password_confirmation = doc.phone[-6..]
  end

end
