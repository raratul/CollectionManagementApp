json.extract! collection, :id, :name, :description, :topic, :image, :user_id, :created_at, :updated_at
json.url collection_url(collection, format: :json)
