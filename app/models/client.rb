class Client < ActiveRecord::Base
  belongs_to :Office
  has_many :products
  has_many :client_users
  has_many :transactions
  validates_presence_of :name
end
