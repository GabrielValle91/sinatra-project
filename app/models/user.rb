class User < ActiveRecord::Base
  validates_presence_of :username, :password
  has_secure_password
  has_many :clients
  has_many :transactions, through: :clients
end
