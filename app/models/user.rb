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
  field :status, type: String, default: 'ENABLED' #ENABLED,DISABLE


  field :birthday, type: Date
  field :wechat, type: String, default: ''

  belongs_to :school, optional: true

  search_in :name, :phone, :acct_no

  has_secure_password
  has_secure_password :recovery_password, validations: false









end
