json.array!(@comments) do |comment|
  json.extract! comment, :user_id, :article_id, :body, :done
  json.url comment_url(comment, format: :json)
end
