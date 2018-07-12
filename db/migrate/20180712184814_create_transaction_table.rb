class CreateTransactionTable < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :reference
      t.string :transaction_type
      t.integer :client_id
      t.date :transaction_date
    end
  end
end
