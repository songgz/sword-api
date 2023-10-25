class MenuItem
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Tree

  field :title, type: String
  field :link, type: String, default: ''
  field :icon, type: String, default: ''
  field :sign, type: String
  field :desc, type: String
end
