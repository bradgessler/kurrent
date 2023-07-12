json.extract! user, :id, :name, :account_id, :timezone, :created_at, :updated_at
json.url user_url(user, format: :json)
