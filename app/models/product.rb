class Product < ActiveRecord::Base
  belongs_to :client
  validates_presence_of :name
  has_many :line_items
  has_many :transactions, through: :line_items
end
