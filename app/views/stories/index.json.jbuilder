json.array!(@stories) do |story|
  json.extract! story, :id, :title, :user_id, :text, :url, :points
  json.url story_url(story, format: :json)
end
