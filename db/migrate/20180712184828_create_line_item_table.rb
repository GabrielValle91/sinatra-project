class CreateLineItemTable < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.integer :transaction_id
      t.integer :product_id
      t.integer :quantity
    end
  end
end
