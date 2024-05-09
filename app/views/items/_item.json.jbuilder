json.extract! item, :id, :name, :tags, :author, :collection_id, :created_at, :updated_at
json.url item_url(item, format: :json)
