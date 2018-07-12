class CompanyUser < ActiveRecord::Base
  belongs_to :Office
  validates_presence_of :username, :password, :office_id
  has_secure_password
end
