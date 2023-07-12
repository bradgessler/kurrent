json.extract! event, :id, :request_id, :user_agent, :ip_address, :recordable_id, :created_at, :updated_at
json.url event_url(event, format: :json)
