class Transaction < ActiveRecord::Base
  belongs_to :client
  has_many :line_items
  has_many :products, through: :line_items
  validates_presence_of :reference, :transaction_type, :client_id, :transaction_date
end
