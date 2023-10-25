class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :name, type: String
  field :avatar, type: String, default: ''
  field :phone, type: String, default: ''
  field :salt, type: String, default: ''
  field :password_digest, type: String



  field :birthday, type: Date
  field :wechat, type: String, default: ''


  belongs_to :school, optional: true


  has_secure_password


  set_callback(:initialize, :after) do |doc|
    doc.password = '123456'
  end


end
