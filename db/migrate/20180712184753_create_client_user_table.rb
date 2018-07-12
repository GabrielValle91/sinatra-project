class CreateClientUserTable < ActiveRecord::Migration[5.1]
  def change
    create_table :clientusers do |t|
      t.string :username
      t.string :password_digest
      t.integer :client_id
    end
  end
end
