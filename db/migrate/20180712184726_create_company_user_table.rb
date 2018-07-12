class CreateCompanyUserTable < ActiveRecord::Migration[5.1]
  def change
    create_table :companyusers do |t|
      t.string :username
      t.string :password_digest
      t.integer :office_id
    end
  end
end
