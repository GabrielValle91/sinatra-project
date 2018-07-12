class CreateClientTable < ActiveRecord::Migration[5.1]
  def change
      create_table :clients do |t|
        t.string :name
        t.integer :office_id
      end
  end
end
