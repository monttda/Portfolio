json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :text, :points, :parent_id, :story_id
  json.url comment_url(comment, format: :json)
end
