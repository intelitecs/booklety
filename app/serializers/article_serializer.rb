class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :done, :created_at, :updated_at, :comments
end