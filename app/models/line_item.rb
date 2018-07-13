class LineItem < ActiveRecord::Base
  belongs_to :Transaction
  belongs_to :product
end
