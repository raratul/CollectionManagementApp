json.extract! collection, :id, :name, :description, :category, :image, :user_id, :created_at, :updated_at
json.url collection_url(collection, format: :json)
