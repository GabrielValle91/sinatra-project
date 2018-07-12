class Office < ActiveRecord::Base
  has_many :clients
  has_many :company_users
  validates_presence_of :name
end
