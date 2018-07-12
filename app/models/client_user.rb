class ClientUser < ActiveRecord::Base
  belongs_to :client
  validates_presence_of :username, :password, :client_id
  has_secure_password
end
