class CreateOfficeTable < ActiveRecord::Migration[5.1]
  def change
    create_table :offices do |t|
      t.string :name
    end
  end
end
