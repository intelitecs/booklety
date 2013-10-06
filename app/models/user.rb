class User < ActiveRecord::Base
  #attr_accessor :password, :password_confirmation, :email, :username
  default_scope(order 'created_at DESC')
  has_secure_password
  validates :username, :email,presence: :true
  validates_presence_of :password, on: :create
  validates_confirmation_of :password
  validates :username, :email, uniqueness: :true
  validates :username, length: {minimum: 6, maximum: 15}
  validates :password, length: {minimum: 7, maximum: 21}
  EmailRegex = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i
  validates :email, format: {with: self::EmailRegex}
  has_many :comments, dependent: :destroy
  has_many :articles, through: :comments
end
