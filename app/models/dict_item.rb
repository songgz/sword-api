class DictItem
  include Mongoid::Document

  field :value , type: String, default: ''
  field :name, type: String
  field :desc, type: String
  field :color, type: String, default: ''
  field :seq, type: Integer, default: 0

  embedded_in :dict_type, class_name: 'DictType'
end
