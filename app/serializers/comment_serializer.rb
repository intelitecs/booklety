class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :done, :user, :article
  has_one :user
  has_one :article
end
