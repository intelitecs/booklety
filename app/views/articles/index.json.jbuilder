json.array!(@articles) do |article|
  json.extract! article, :id, :title, :description, :comments, :created_at, :updated_at
  json.url article_url(article, format: :json)
end
