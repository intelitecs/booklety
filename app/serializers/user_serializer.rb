class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :comments, :created_at, :updated_at

end