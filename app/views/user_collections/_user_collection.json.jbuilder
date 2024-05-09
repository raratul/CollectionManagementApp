json.extract! user_collection, :id, :user_id, :collection_id, :created_at, :updated_at
json.url user_collection_url(user_collection, format: :json)
