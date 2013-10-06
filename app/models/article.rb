class Article < ActiveRecord::Base
  default_scope(order 'created_at DESC')
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments


end
