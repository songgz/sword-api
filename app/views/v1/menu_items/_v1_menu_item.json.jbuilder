json.extract! v1_menu_item, :id, :parent_id, :title, :sign, :link, :icon, :depth, :created_at, :updated_at
json.is_leaf  v1_menu_item.leaf?
#json.url v1_menu_item_url(v1_menu_item, format: :json)
