class School
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :city_code
  field :address
  field :master_name
  field :master_mobile
  field :status

  has_many :cards
end
