class DictType
  include Mongoid::Document
  include Mongoid::Timestamps
  field :value, type: String, default: ''
  field :name, type: String, default: ''
  field :desc, type: String, default: ''

  embeds_many :dict_items

  class << self
    def dict_items(type_value)
      DictType.where(value: type_value).first.try(:dict_items) || []
    end

    def dict_item(type_value, item_value)
      items(type_value).detect { |item| item.value.to_s == item_value.to_s }
    end

    def item_name(type_value, item_value)
      item(type_value, item_value).try(:name)
    end



  end


end
