class Client < ActiveRecord::Base
  has_many :products
  belongs_to :user
  has_many :transactions
  validates_presence_of :name
end
